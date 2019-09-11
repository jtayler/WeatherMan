//
//  CityDailyView.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct CityDailyView : View {
    
    @State var day: DailyWeather
    
        var body: some View {
            ZStack {
                HStack(alignment: .center) {
                    Text(day.time.formattedDay)
                        .padding()
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Text(day.minTemperature.temperatureFormatted)
                            .foregroundColor(.secondary)

                        Text(day.maxTemperature.temperatureFormatted)
                        }
                        .padding()
                }
                HStack(alignment: .center) {
                    day.icon.glyph
                }
            }
        }
        
}

//#if DEBUG
//struct CityDailyView_Previews : PreviewProvider {
//    static var previews: some View {
//        CityDailyView()
//    }
//}
//#endif
