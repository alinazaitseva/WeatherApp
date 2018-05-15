//
//  Weather.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/15/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

class WeatherGetter {
    
    private let openWeatherMapBaseURL = "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search"
    private let openWeatherMapAPIKey = "ituhiuyh8654QSIdqe5TyzsJt55qpFv9"
    
    func getWeather(latitude: Double, longitude: Double) {
        let session = URLSession.shared
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?apikey=\(openWeatherMapAPIKey)&q=\(latitude),\(longitude)")!
    
        let dataTask = session.dataTask(with: weatherRequestURL) { (data, response, error) in
            if let error = error {
              
                print("Error:\n\(error)")
            }
            else {
               
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                print("Data:\n\(dataString!)")
            }
        }
        dataTask.resume()
    }
}
