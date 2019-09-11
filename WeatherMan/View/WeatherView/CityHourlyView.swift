//
//  CityHourlyView.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct CityHourlyView : View {
    
    @ObservedObject var city: City

    private let rowHeight: CGFloat = 184


    func max() -> Double {
        return (city.weather?.hours.list.max()?.temperature)!
    }
    
    func min() -> Double {
        return (city.weather?.hours.list.min()?.temperature)!
    }
        
    func offsetFor(temperature: Double) -> Double {
        let range = (max() - min())
        let percentage = (temperature - min()) / range
        return (((temperature - min()) / range ) * 80) - 40 * percentage
    }

//    struct OffsetIcon : View {
//
//        @ObservedObject var hour: HourlyWeather
//        var offset = self.offsetFor(temperature: hour.temperature)
//
//        var body: some View {
//            hour.icon.glyph
//                .offset(y: offset)
//                .padding()
//
//        }
//
//
//    }

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(city.weather?.hours.list ?? []) { hour in
                    Group {
                        VStack {
                            
                            //Text("\(self.offsetFor(temperature: hour.temperature))")
                            Text(hour.time.formattedHour)
                                .font(.footnote)
                            
                            hour.icon.glyph
//                                .offset(y: 20)
                                .padding()

                            Text(hour.temperature.temperatureFormatted)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding([.trailing, .leading])
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding(.vertical)
//        .frame(height: rowHeight)
    }
    
}

//#if DEBUG
//struct CityHourlyView_Previews : PreviewProvider {
//    static var previews: some View {
//        CityHourlyView()
//    }
//}
//#endif
