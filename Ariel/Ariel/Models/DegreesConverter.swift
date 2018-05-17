//
//  DegreesConverter.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/17/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

class DegreesConverter {
    
    private var fahrenheit: Double
    
    init(fahrenheit: Double) {
                self.fahrenheit = fahrenheit
    }
    
    var celsiFormat: String {
                return prepareDegreeLabel(from: fahrenheit)
    }
    
    private func prepareDegreeLabel(from: Double) -> String {
                let celsi = convertToCelsius(fahrenheit: Int(from))
                return celsi >= 0 ? "+\(celsi)C" : "\(celsi)C"
    }
    
    private func convertToCelsius(fahrenheit: Int) -> Int {
                return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
        
    }
}
