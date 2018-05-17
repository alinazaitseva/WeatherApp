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
    
    var convertTo: String {
                return prepareDegrees(from: fahrenheit)
    }
    
    private func prepareDegrees(from: Double) -> String {
        let celsiusDegree = convertToCelsius(fahrenheit: Int(from))
        if celsiusDegree >= 0 {
            return "+\(celsiusDegree)"
        } else {
            return "\(celsiusDegree)"
        }
    }
    
    private func convertToCelsius(fahrenheit: Int) -> Int {
                return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
        
    }
}
