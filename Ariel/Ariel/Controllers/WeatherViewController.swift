//
//  WeatherViewController.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/16/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var weatherTableview: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var forecastData = [DailyWeather]()
    
    var hourlyData = [HourlyWeather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeatherForLocation(location: "Vinnytsia")
        updateWeatherForLocationHourly(location: "Vinnytsia")
    }
    
    func updateWeatherForLocation (location:String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    DailyWeather.forecast(withLocation: location.coordinate, completion: { (results:[DailyWeather]?) in
                        
                        if let weatherData = results {
                            self.forecastData = weatherData
                            
                            DispatchQueue.main.async {
                                self.weatherTableview.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    
    func updateWeatherForLocationHourly (location:String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    HourlyWeather.forecast(withLocation: location.coordinate, completion: { (results:[HourlyWeather]?) in
                        
                        if let weatherDataHourly = results {
                            self.hourlyData = weatherDataHourly
                            
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let weatherObject = forecastData[indexPath.section]
        
        cell.textLabel?.text = weatherObject.summary
        cell.detailTextLabel?.text = "\(Int(weatherObject.temperature)) °F"
        cell.imageView?.image = UIImage(named: weatherObject.icon)
        temperatureLabel.text = "\(Int(weatherObject.temperature)) °F"
        weatherStateLabel.text = "\(weatherObject.icon)"
        cityLabel.text = "Vinnytsia"
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        let hourlyWeatherOblect = hourlyData[indexPath.section]
        
        cell.collectionLabel?.text = "\(Int(hourlyWeatherOblect.temperature)) °F"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }
}
