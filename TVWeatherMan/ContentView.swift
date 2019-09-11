//
//  ContentView.swift
//  TVWeatherMan
//
//  Created by Jesse Tayler on 8/9/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var cityStore: CityStore

    var body: some View {
        TVCityWeatherView(city: self.cityStore.cities[0])
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
