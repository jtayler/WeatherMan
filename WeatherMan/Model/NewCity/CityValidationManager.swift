//
//  CityValidationManager.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import Foundation

class CityValidationManager: NSObject {
    
    class func validateCity(withID placeID: String, _ completion: @escaping (_ city: City?) -> Void) {
        guard let url = URL(string: API.APIURL.cityDataRequest(for: placeID)) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(CityValidationManager.Result.self, from: data)
                completion(City(cityData: result.cityData))
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }

}

extension CityValidationManager {

struct Result: Codable {
    var cityData: CityData
    enum CodingKeys: String, CodingKey {
        case cityData = "result"
    }
}

struct CityData: Codable {
    var name: String
    var geometry: Geometry
    
    struct Geometry: Codable {
        var location: Location
        
        struct Location: Codable {
            var longitude: Double
            var latitude: Double
            
            enum CodingKeys: String, CodingKey {
                case longitude = "lng"
                case latitude = "lat"
            }
        }
    }
}
}
