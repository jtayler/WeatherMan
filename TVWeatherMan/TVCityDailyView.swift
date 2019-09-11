//
//  TVCityDailyView.swift
//  TVWeatherMan
//
//  Created by Jesse Tayler on 8/9/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct TVCityDailyView : View {
    
    @State var day: DailyWeather
    
        var body: some View {
            ZStack {
                HStack(alignment: .center) {
                    Text(day.time.formattedDay)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Text(day.minTemperature.temperatureFormatted)
                            .fixedSize(horizontal: true, vertical: false)
                            .foregroundColor(.secondary)

                        Text(day.maxTemperature.temperatureFormatted)
                            .fixedSize(horizontal: true, vertical: false)
                        }
                }
                HStack(alignment: .center) {
                    day.icon.glyph
                }

            }
        }
        
}

