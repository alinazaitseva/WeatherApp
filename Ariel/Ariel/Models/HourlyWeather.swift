//
//  HourlyWeather.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/16/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation
import CoreLocation

struct HourlyWeather {
    let time: Int
    let temperature: Double
    
    enum SerealizationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        
        guard let time = json["time"] as? Int else {throw SerealizationError.missing("summary is missing")}
        
        guard let temperature = json["temperature"] as? Double else {throw SerealizationError.missing("temp is missing")}
        
        self.time = time
        self.temperature = temperature
    }
    
    static let basePath = "https://api.darksky.net/forecast/2c73b2906faf137f2f19c38fc3454588/"
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([HourlyWeather]?) -> ()) {
        
        let url = basePath + "\(location.latitude),\(location.longitude)"
        let request = URLRequest(url: URL(string: url)!)
        
         let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastHourlyArray:[HourlyWeather] = []
            if let data = data {
                do {
                    let dayHour = 12
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let hourlyForecasts = json["hourly"] as? [String:Any] {
                            if let hourlyData = hourlyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in hourlyData.prefix(dayHour) {
                                    if let weatherObject = try? HourlyWeather(json: dataPoint) {
                                        forecastHourlyArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    
                    print(error.localizedDescription)
                }
                completion(forecastHourlyArray)
            }
    }
      task.resume()
    }
}
