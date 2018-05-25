//
//  CityModel.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/21/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

class CityModel {
    
    var cities: [String] = []
    var previousCity = 0
    var isDoingOperation = true
    var lastCity: Int {
        return self.cities.count
    }
    
    var cityAmount: Int {
        return self.cities.count
    }
    var addedCity: Bool {
        return previousCity < cityAmount
    }
    
    func isNotRepeatedCity(_ newCity: String) -> Bool {
            for city in self.cities {
                    if city == newCity {
                        return false
                }
            }
            return true
    }
    func addCity(_ city: String) {
        if isNotRepeatedCity(city) {
            self.cities.append(city)
        }
    }
    
    func showCities() {
        print(self.cities)
    }
}
