//
//  CityHeaderView.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

struct Tall: View {
    @ObservedObject var city: City

    var body: some View {
        VStack() {
            city.weather?.current.icon.glyph
                .font(.system(size: 120, weight: .ultraLight))
                .imageScale(.medium)
                .padding(.top)

            Text(city.temperatureFormatted)
                .font(.system(size: 120))
                .fontWeight(.ultraLight)
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding()
    }
}

struct Wide: View {
    @ObservedObject var city: City

    var body: some View {
        HStack {
            city.weather?.current.icon.glyph
                .font(.system(size: 280, weight: .ultraLight))
                .imageScale(.small)
                .padding()

            Text(city.temperatureFormatted)
                .font(.system(size: 280))
                .fontWeight(.ultraLight)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding()
    }
}

struct CityHeaderView: View {
    
    @ObservedObject var city: City
    
    var body: some View {
        
        VStack {
            Group {
                HStack() {
                    Spacer()
                    
//                    Text("Is tall? \(isScreenTall.description)")
                        

                    Tall(city:city)

                    Spacer()
                }
                
                Text(city.formattedSummary)
                    .multilineTextAlignment(.center)
                
                Text(city.longerSummary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true) // this should not be needed because lineLimit should work?
            }
        }
    }
    
}


//#if DEBUG
//struct CityHeader_Previews : PreviewProvider {
//    static var previews: some View {
//        CityHeaderView()
//    }
//}
//#endif
