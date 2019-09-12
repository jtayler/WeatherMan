//
//  CityWeatherView.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct CityWeatherView : View {
    
    @ObservedObject var city: City
    @State private var isPresenting: Bool = false

    func formattedTime(city: City) -> String {
        guard let weather = city.weather else {
            return "--º"
        }
        return weather.current.time.formattedTime
    }
    
    var formattedTime: String {
        guard let weather = city.weather else {
            return "--º"
        }
        return weather.current.time.formattedTime
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Section {
                CityHeaderView(city: city)
                    .padding()
                
                ForEach(city.weather?.alerts ?? []) { alert in
                    Button(action: {
                        self.$isPresenting.wrappedValue.toggle()
                    }) {
                        HStack {
                            Image(systemName: "chevron.right.circle")
                                .rotationEffect(.degrees(self.isPresenting ? 90 : 0))
                            Text("\(alert.title)")
                        }
                        .foregroundColor(.red)
                    }
                    Text(self.isPresenting ? "\(alert.description)" : "")
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.leading,.trailing])
                }
            }
            .padding()
            
            Divider()
            
            Section {
                CityHourlyView(city: city)
            }
            
            Divider()
            
            Section {
                ForEach(city.weather?.week.list ?? []) { day in
                    CityDailyView(day: day)
                }
            }
            
            Divider()
            
            Spacer()
            
            Section {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Updated \(formattedTime(city: city))") // \nCopyright © 2019 OEI
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            }
            .padding()
            
        }
        .onAppear {
            Network.fetchWeather(for: self.city) { (weather) in }
        }
        .navigationBarTitle(Text(city.name), displayMode: .inline)
    }
    
}

//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        CityWeatherView()
//    }
//}
//#endif
