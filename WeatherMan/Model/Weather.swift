//
//  Weather.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct WeatherAlert: Codable, Identifiable {
    
    var id: Date {
        return time
    }
    
    var time: Date
    var title: String

    enum CodingKeys: String, CodingKey {
        case time = "time"
        case title = "title"
    }
    
}

struct Weather: Codable {
    
    var current: HourlyWeather
    var hours: Weather.List<HourlyWeather>
    var week: Weather.List<DailyWeather>
    var alerts: Array<WeatherAlert>!

    enum CodingKeys: String, CodingKey {
        case current = "currently"
        case hours = "hourly"
        case week = "daily"
        case alerts = "alerts"
    }
    
}

extension Weather {
    
    enum Icon: String, Codable {
        
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        
        case partyCloudyDay = "partly-cloudy-day"
        case partyCloudyNight = "partly-cloudy-night"
        
        var glyph: Image {
            switch self {
            case .clearDay:
                return Image(systemName: "sun.max")
            case .clearNight:
                return Image(systemName: "moon.stars")
            case .rain:
                return Image(systemName: "cloud.rain")
            case .snow:
                return Image(systemName: "snow")
            case .sleet:
                return Image(systemName: "cloud.sleet")
            case .wind:
                return Image(systemName: "wind")
            case .fog:
                return Image(systemName: "cloud.fog")
            case .cloudy:
                return Image(systemName: "cloud")
            case .partyCloudyDay:
                return Image(systemName: "cloud.sun")
            case .partyCloudyNight:
                return Image(systemName: "cloud.moon")
            }
        }
    }
    
}

