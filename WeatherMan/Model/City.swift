//
//  City.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI
import Combine

struct CodableCity: Codable {
    var name: String
    var longitude: Double
    var latitude: Double
    var isLocal: Bool
}

final class City: ObservableObject, Identifiable, Decodable {
    
    var objectWillChange = PassthroughSubject<City, Never>()
    
    var name: String
    var longitude: Double
    var latitude: Double
    var isLocal = true

    var image: UIImage?
    
    var weather: Weather? {
        didSet {
            objectWillChange.send(self)
        }
    }
    var temperatureFormatted: String {
        guard let temperature = weather?.current.temperature else {
            return "--º"
        }
        return temperature.temperatureFormatted
    }
    var formattedSummary: String {
        return "\(weather?.current.summary ?? "")"
    }
    var longerSummary: String {
        return "\(weather?.week.list.first?.summary ?? "")"
    }
    var formattedTime: String {
        guard let weather = weather else {
            return "--"
        }
        return weather.current.time.formattedTime
    }

    init() {
        //https://api.darksky.net/forecast/06df7cdb8547340e6e47dc25bfc1aafb/40.744964,-73.977041
        self.name = "Unknown City"
        self.longitude = 0//122.03121860
        self.latitude = 0//37.33233141
        self.isLocal = true
    }
    
    init(cityData data: CityValidationManager.CityData) {
        self.name = data.name
        self.longitude = data.geometry.location.longitude
        self.latitude = data.geometry.location.latitude
        self.isLocal = false
    }

    init(name: String, longitude: Double, latitude: Double, isLocal: Bool) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.isLocal = isLocal
    }

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case isLocal
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)

        isLocal = try values.decode(Bool.self, forKey: .isLocal)

        name = try values.decode(String.self, forKey: .name)
    }

}

extension City: Equatable {
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.isLocal == rhs.isLocal
    }
}

extension City: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(isLocal, forKey: .isLocal)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
    }
}

extension City {
    struct CodingData: Codable {
        struct CodableCity: Codable {
            var name: String
            var longitude: Double
            var latitude: Double
            var isLocal: Bool
        }

        var codableData: CodableCity
    }
}

extension City.CodingData {
    var city: City {
        return City(
            name: codableData.name,
            longitude: codableData.longitude,
            latitude: codableData.latitude,
            isLocal: codableData.isLocal
        )
    }
}

