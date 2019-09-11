//
//  Date.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import Foundation

extension Date {
    
    func isThisHour() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYMMEEHH"
        
        let then = dateFormatter.string(from: self)
        let now = dateFormatter.string(from: Date())
        if now == then {
            return true
        }
        return false
    }
    
    func isThisMinute() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYMMEEHHMM"
        
        let then = dateFormatter.string(from: self)
        let now = dateFormatter.string(from: Date())
        if now == then {
            return true
        }
        return false
    }
    
    var formattedHour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "hb"
        
        let hour = dateFormatter.string(from: self)

        if isThisHour() {
            return "Now"
        }
        
        return hour.lowercased()
    }
    
    var formattedDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }

    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"

        let dayDateFormatter = DateFormatter()
        dayDateFormatter.dateFormat = "EEEE"
        let now = dayDateFormatter.string(from: Date())

        if now == formattedDay {
            return "Today at \(dateFormatter.string(from: self))"
        }

        dateFormatter.dateFormat = "EEEE at h:mma"

        return dateFormatter.string(from: self)
    }

}
