//
//  ForecastDateTime.swift
//  Ariel
//
//  Created by Alina Zaitseva on 5/20/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

class ForecastDateTime {
    let rawDate: Int
    
    init(_ date: Int) {
        rawDate = date
    }
    
    var shortTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(rawDate))
        return dateFormatter.string(from: date)
    }
}
