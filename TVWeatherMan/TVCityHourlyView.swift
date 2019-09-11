//
//  TVCityHourlyView.swift
//  TVWeatherMan
//
//  Created by Jesse Tayler on 8/9/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct TVCityHourlyView : View {
    
    @ObservedObject var city: City

    private let rowHeight: CGFloat = 184

    var body: some View {
            HStack {
                ForEach(city.weather?.hours.list.prefix(8) ?? []) { hour in
                    Group {
                        VStack {
                            Text(hour.time.formattedHour)
                                .font(.footnote)
                            .fixedSize(horizontal: true, vertical: false)

                            hour.icon.glyph
                                .padding()

                            Text(hour.temperature.temperatureFormatted)
                                .foregroundColor(.secondary)
                            .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                }
            }
            .fixedSize(horizontal: true, vertical: false)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
}
