//
//  Double.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import Foundation

extension Double {
    
    var temperatureFormatted: String {
        let formatter = NumberFormatter()
        formatter.allowsFloats = false
        
        let formattedDouble = formatter.string(from: NSNumber(value: self)) ?? "--"
        return formattedDouble + "º"
    }
    
}
