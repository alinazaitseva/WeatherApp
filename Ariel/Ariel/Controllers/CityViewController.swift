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


class CityViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func dissmis(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
//        if let locationString = searchBar.text, !locationString.isEmpty {
//            updateWeatherForLocation(location: locationString)
//        }
    }
}
