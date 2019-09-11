//
//  WatchCityWeatherView.swift
//  WatchWeatherMan Extension
//
//  Created by Jesse Tayler on 8/9/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI
import Combine

struct WatchCityWeatherView : View {
    
    @ObservedObject var city: City

    func prefixList() -> Array<DailyWeather> {
        guard let weather = city.weather else {
            return []
        }
        let val = weather.week.list.prefix(5)
        return Array(val)
    }
    
    func fetch() {
        Network.fetchWeather(for: self.city) { (weather) in }
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    city.weather?.current.icon.glyph
                        .font(.system(size: 55, weight: .light))
                        .imageScale(.small)
                        .padding(.top)

                    Text(city.weather?.current.temperature
                        .temperatureFormatted ?? "-º")
                        .font(.system(size: 55, weight: .light))
                }
                .animation(.easeInOut(duration: 1))
                .padding([.top, .bottom])


                VStack {
                    Text(city.name)
                        .font(.system(.title))
                    
                    Text("\(city.formattedSummary)")
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true) // this should not be needed because lineLimit should work?
                }
                .frame(height:80)

                Divider()

                VStack {
                    Text("\(city.longerSummary)")
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true) // this should not be needed because lineLimit should work?

                    Spacer()
                    
                    Text("Updated \(city.formattedTime)")
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .frame(height:60)
                }
                .padding(.top)
                .animation(.easeInOut(duration: 1))
            }
        }
    }
    
}
