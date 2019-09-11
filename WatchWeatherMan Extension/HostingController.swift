//
//  HostingController.swift
//  WatchWeatherMan Extension
//
//  Created by Jesse Tayler on 8/9/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<AnyView> {
    
    let delegate = WKExtension.shared().delegate as! ExtensionDelegate

    let cityStore = CityStore(isLargeView: false)
    
    override init() {
        cityStore.decode()
    }
    
    override func didAppear() {
        Location.shared.cityStore = cityStore
        Location.shared.startUpdating()
        if let city = cityStore.cities.first {
            Network.fetchWeather(for: city) { (weather) in }
        }

    }

    override var body: AnyView {
        return AnyView(ContentView().environmentObject(cityStore))
    }

//    override var body: ContentView {
//        ContentView().environmentObject(cityStore) as! ContentView
//    }
}
