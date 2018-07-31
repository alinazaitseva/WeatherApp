//
//  CityViewController.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/17/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit
import CoreLocation

class CityViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    let locationManager = CLLocationManager()
    var cityManager = CityManager()
    var delegate: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            guard let delegate = delegate else { return }
            delegate.cityManager.addCity(locationString)
            delegate.orderedController = delegate.addPage()
            delegate.setViewControllers([delegate.orderedController.last!], direction: .forward, animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
