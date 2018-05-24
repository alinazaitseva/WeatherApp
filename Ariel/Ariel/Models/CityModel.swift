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
    
    var cityAmount: Int {
        return self.cities.count
    }
    
    func isNotDuplicatedCity(_ newCity: String) -> Bool {
            for city in self.cities {
                    if city == newCity {
                            return false
                        }
                }
            return true
        }
    func addCity(_ city: String) {
        if isNotDuplicatedCity(city) {
            self.cities.append(city)
        }
    }
    
    func showCities() {
        print(self.cities)
    }
}
