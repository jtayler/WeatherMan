//
//  HourlyWeather.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct HourlyWeather: Codable, Identifiable, Comparable {

    var time: Date
    var temperature: Double
    var apparentTemperature: Double
    var summary: String
    var icon: Weather.Icon
    var id: Date {
        return time
    }
    
    static func <(lhs: HourlyWeather, rhs: HourlyWeather) -> Bool {
        return lhs.temperature < rhs.temperature
    }

    static func ==(lhs: HourlyWeather, rhs: HourlyWeather) -> Bool {
        return lhs.temperature == rhs.temperature
    }

}
