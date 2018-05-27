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
    var weatherManager = WeatherViewController()
    var delegate: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            guard let connection = delegate else { return }
            connection.cityManager.addCity(locationString)
            connection.orderedController = connection.addPage()
            connection.setViewControllers([connection.orderedController.last!], direction: .forward, animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
