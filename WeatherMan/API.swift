//
//  API.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import Foundation

class API: NSObject {
    
    // Get your dark sky key here
    // https://darksky.net/dev/register
    // Get your google places API key here
    // https://cloud.google.com/maps-platform/places/
    // You'll need to turn on the API key
    // which takes a few steps to complete
    //
    
    struct Key {
        static let darkSkyKey: String = ""
        static let googlePlacesKey: String = ""
        static let geonamesLoginKey: String = ""
    }
    
    struct APIURL {
        
        static func weatherRequest(longitude: Double, latitude: Double) -> String {
            return "https://api.darksky.net/forecast/\(API.Key.darkSkyKey)/\(latitude),\(longitude)?units=auto".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
        static func predictionRequest(for search: String) -> String {
            return "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(search)&types=(cities)&key=\(API.Key.googlePlacesKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
        static func cityDataRequest(for placeID: String) ->  String {
            return "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=\(API.Key.googlePlacesKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
    }
        
}
