//
//  Network.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import Foundation

class Network {
    
    static func fetchWeather(for city: City, _ completion: @escaping (_ weather: Weather?) -> Void) {
        if (city.latitude + city.longitude != 0) {
            guard let url = URL(string: API.APIURL.weatherRequest(longitude: city.longitude, latitude: city.latitude)) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    let weatherObject = try decoder.decode(Weather.self, from: data)
                    
                    print("fetch weather \(url)")
                    DispatchQueue.main.async {
                        city.weather = weatherObject
                    }
                    completion(weatherObject)
                } catch {
                    print("Failed decoding of weather data. \(error.localizedDescription)")
                    completion(nil)
                }
            }.resume()
        }
    }
    
}

