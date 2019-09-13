//
//  CityRow.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI
import CoreLocation

struct CityRow : View {
    
    @ObservedObject var city: City
    
    var isWide: Bool
    var isEditing: Bool
    
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
        NavigationLink(destination:
            Group {
                // this just doesn't work!
                //
                CityWeatherView(city: city)
                if isWide {
                } else {
                    //CityWeatherBigView(city: city)
                }
            }

        ) {
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
                HStack {
                    if !isEditing {
                        Group {
                            city.weather?.current.icon.glyph
                                .foregroundColor(.secondary)
                                .font(.title)
                            Text(city.weather?.current.temperature
                                .temperatureFormatted ?? "-º")
                                .foregroundColor(.secondary)
                                .font(.title)
                        }
                    }
                }
                .animation(.easeInOut(duration: 1))
            }
            .padding([.trailing, .top, .bottom])
        }
        .onAppear {
            Network.fetchWeather(for: self.city) { (weather) in }
        }
    }
    
    
}

//#if DEBUG
//struct CityRow_Previews : PreviewProvider {
//    static var previews: some View {
//        CityRow()
//    }
//}
//#endif
