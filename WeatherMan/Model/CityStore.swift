//
//  CityStore.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI
import Combine

extension Notification.Name {
    static let my_onViewWillTransition = Notification.Name("MainUIHostingController_viewWillTransition")
}

final class CityStore: ObservableObject, Identifiable {
    
    @Published var cities: [City] = [City()] {
        didSet {
            encode()
        }
    }
    
    @Published var largeView: Bool = false

    
    init(isLargeView: Bool) {
        self.largeView = isLargeView // Initial value
        NotificationCenter.default.addObserver(self, selector: #selector(onViewWillTransition(notification:)), name: .my_onViewWillTransition, object: nil)
    }

    @objc func onViewWillTransition(notification: Notification) {
        guard let size = notification.userInfo?["size"] as? CGSize else { return }

        print("viewWillTransition to \(size)")

        largeView = size.width > size.height
    }
    
    func encode() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cities)
            UserDefaults.standard.set(data, forKey: "CityStore")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func decode() {
        if let data = UserDefaults.standard.object(forKey: "CityStore") as? Data {
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Array<City>.self, from: data)
                cities = results
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
