//
//  Location.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import Combine
import SwiftUI
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate, ObservableObject, Identifiable {
    
    static let shared = Location()
    
    @Published var cityStore: CityStore
    
    private let manager: CLLocationManager
    
    var localCity = City()
    
    var location: CLLocation?
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        self.cityStore = CityStore(isLargeView: true)
        super.init()
    }
    
    func startUpdating() {
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.distanceFilter = 100
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        
        manager.requestLocation()
        manager.startUpdatingLocation()
    }
    
    func startReceivingSignificantLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus != .authorizedAlways && authorizationStatus != .authorizedWhenInUse {
            print("not authorized")
            return
        }
        
        #if os(OSX)
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            print("significantLocationChangeMonitoring not available")
            manager.startMonitoringSignificantLocationChanges()
        }
        manager.startUpdatingLocation()
        #endif
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager location change \(locations)")
        location = locations.last
        if let location = location {
            self.reverseGeo(location: location)
        }
        
    }
    
    func reverseGeo(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
            if let error = error {
                print("reverse geodcode fail: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                self.updateCity(toPlacemark: placemark)
            }
        })
    }
    
    func updateCity(toPlacemark: CLPlacemark) {
        if let name = toPlacemark.locality {
            if localCity.name != name {
                if let location = toPlacemark.location {
                    localCity = City(name: name, longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, isLocal: true)
                    
                    print("located \(localCity.name)")
                    
                    guard let city = cityStore.cities.first else {
                        cityStore.cities.insert(localCity, at: 0)
                        return
                    }
                    
                    if city.isLocal {
                        cityStore.cities.remove(at: 0)
                    }
                    cityStore.cities.insert(localCity, at: 0)

                    print("city count \(cityStore.cities.count)")

                    #if os(OSX)
                    #elseif os(iOS)
                    #elseif os(tvOS)
                    Network.fetchWeather(for: localCity) { (weather) in }
                    #elseif os(watchOS)
                    Network.fetchWeather(for: localCity) { (weather) in }
                    #endif
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            #if os(OSX)
            manager.startUpdatingLocation()
            #elseif os(iOS)
            // compiles for iOS
            #elseif os(tvOS)
            // compiles for TV OS
            #elseif os(watchOS)
            // compiles for Apple watch
            #endif
        }
    }
}
