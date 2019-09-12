//
//  CityWeatherBigView.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/10/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct CityWeatherBigView : View {
    
    @ObservedObject var city: City
    
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
                VStack {
                    Group {
                        HStack() {
                            Spacer()
                            
                            HStack(spacing: 64) {
                                city.weather?.current.icon.glyph
                                    .font(.system(size: 250, weight: .ultraLight))
                                    .imageScale(.medium)
                                    .padding(.top)
                                
                                Text(city.temperatureFormatted)
                                    .font(.system(size: 250))
                                    .fontWeight(.ultraLight)
                            }
                            .fixedSize(horizontal: true, vertical: false)
                            .padding()
                            
                            Spacer()
                        }
                        
                        Text(city.formattedSummary)
                            .multilineTextAlignment(.center)
                        
                        Text(city.longerSummary)
                            .multilineTextAlignment(.center)

                    }
                }
                .padding()
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
                    //                        CurrentDateView(city: city)
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
