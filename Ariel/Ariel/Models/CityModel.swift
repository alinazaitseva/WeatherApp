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
   
    var cityAmount: Int {
        return self.cities.count
    }
    
    var addedCity: Bool {
        return previousCity < cityAmount
    }
    
    func addCity(_ city: String) {
        var isCityNotExist = true
        for item in self.cities {
            if city == item {
                isCityNotExist = false
            }
        }
        if isCityNotExist {
            self.cities.append(city)
        }
    }
    
}
