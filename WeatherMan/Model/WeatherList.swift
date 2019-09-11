//
//  WeatherList.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

extension Weather {
    
    struct List<T: Codable & Identifiable>: Codable {
        var list: [T]
        
        enum CodingKeys: String, CodingKey {
            case list = "data"
        }
    }
    
}
