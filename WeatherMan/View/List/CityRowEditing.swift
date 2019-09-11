//
//  CityRowEditing.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/9/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI
import CoreLocation

struct CityRowEditing : View {
    
    @ObservedObject var city: City

    var locationIconName: String {
        get {
            if isAuthorized {
                return "location.fill"
            }
            if isDenied {
                return "location.slash"
            }
            return "location"
        }
    }
    
    var isAuthorized: Bool {
        get {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
                return true
            }
            return false
        }
    }
    
    var isDenied: Bool {
        get {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            if authorizationStatus == .denied {
                return true
            }
            return false
        }
    }
    
    var body: some View {
        NavigationLink(destination: CityWeatherView(city: city)) {
            HStack(alignment: .firstTextBaseline) {
                
                if city.isLocal {
                    Image(systemName: locationIconName)
                        .foregroundColor(isAuthorized ? .accentColor : .secondary)
                        .font(.title)
                        .imageScale(.small)
                }
                Text(city.name)
                    .font(.title)
                
                Spacer()
                
                .animation(.easeInOut(duration: 1))
            }
            .padding([.trailing, .top, .bottom])
        }
    }
    
    
}
