//
//  WeatherAlert.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 9/12/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct WeatherAlert: Codable, Identifiable {
    
    var id: Date {
        return time
    }
    
    var time: Date
    var title: String
    var description: String
    var uri: String

    enum CodingKeys: String, CodingKey {
        case time = "time"
        case title = "title"
        case uri = "uri"
        case description = "description"
    }
    
}


