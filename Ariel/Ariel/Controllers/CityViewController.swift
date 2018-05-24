//
//  CityViewController.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/17/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CityViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    let locationManager = CLLocationManager()
    var cityManager = CityModel()
    var mainManager = WeatherViewController()
    var pageViewController: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if mainManager.cityName != nil {
            mainManager.updateWeatherForLocationHourly(location: self.mainManager.cityName!)
            mainManager.updateWeatherForLocation(location: self.mainManager.cityName!)
        } else {
            mainManager.lookUpCurrentLocation { (placemark) in
                guard let locality:  String = placemark?.locality else { return }
                self.mainManager.cityName = locality
                self.mainManager.updateWeatherForLocation(location: locality)
                self.mainManager.updateWeatherForLocationHourly(location: locality)
            }
        }
    }
    
    @IBAction func dissmis(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            mainManager.updateWeatherForLocation(location: locationString)
            mainManager.updateWeatherForLocationHourly(location: locationString)
        }
    }
    
    @IBAction func addCity(_ sender: UIButton) {
    
    }
}
