//
//  TVCityWeatherView.swift
//  TVWeatherMan
//
//  Created by Jesse Tayler on 8/9/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct CurrentDateView : View {
    
    @ObservedObject var city: City
    
    let timer = Timer.publish(every: 60*15, on: .current, in: .common).autoconnect()
    func formattedTime(city: City) -> String {
        guard let weather = city.weather else {
            return "--º"
        }
        return weather.current.time.formattedTime
    }
    
    var body: some View {
        Text("Updated \(city.weather?.current.time.formattedTime ?? "")") // \nCopyright © 2019 OEI
            .font(.footnote)
            .foregroundColor(.secondary)
            .onReceive(timer) {_ in
                Network.fetchWeather(for: self.city) { (weather) in }
        }
    }
}

struct WeatherIconStack : View {
    
    @ObservedObject var city: City
    @State private var isPresenting: Bool = false

    var body: some View {
        VStack(alignment: .trailing) {
            if city.weather != nil {
                Group {
                    city.weather?.current.icon.glyph
                        .imageScale(.small)
                        .font(.system(size: 600, weight: .ultraLight))
                        .padding(60)
                    
                    Text(city.name)
                        .font(.system(.largeTitle))
                        .fontWeight(.bold)
                    
                    Text("\(city.formattedSummary)")
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)

                    ForEach(city.weather?.alerts ?? []) { alert in
                        Text("\(alert.title)")
                            .foregroundColor(.red)
                        Text(self.isPresenting ? "\(alert.description)" : "")
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding([.leading,.trailing])
                    }
                }
                .frame(width: 680)
            }
        }
    }

}


struct WeatherStack : View {
    
    @ObservedObject var city: City

    func prefixList() -> Array<DailyWeather> {
        guard let weather = city.weather else {
            return []
        }
        let val = weather.week.list.prefix(6)
        return Array(val)
    }

    var body: some View {
        VStack(alignment: .trailing) {
            Text(city.temperatureFormatted)
                .font(.system(size: 320))
                .fontWeight(.semibold)
                .animation(.easeInOut(duration: 1))
                .frame(height:320)

            Text(city.longerSummary)
                .fontWeight(.light)
                .multilineTextAlignment(.center)

            Divider()
            
            TVCityHourlyView(city: city)
            
            Divider()
            
            ForEach(prefixList()) { day in
                TVCityDailyView(day: day)
            }
        }
    }
}

struct TVCityWeatherView : View {
    
    @ObservedObject var city: City
    
    var body: some View {
        Group {
            HStack(alignment: .top) {
                WeatherIconStack(city: city)
                .animation(.easeInOut(duration: 2.1))

                Spacer()
                
                WeatherStack(city: city)
            }
            .padding(.top)

            Spacer()
            
            VStack() {
                CurrentDateView(city: city)
                    .padding(.top)
            }
        }
        .onAppear { Network.fetchWeather(for: self.city) { (weather) in } }
    }

}


