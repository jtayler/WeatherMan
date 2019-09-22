//
//  Color.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 9/9/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI

extension UIColor {
    
    public convenience init?(hex: String) {
        let r, g, b: CGFloat
        var a: CGFloat
        
        let start = hex.index(hex.startIndex, offsetBy: hex.hasPrefix("#") ? 1 : 0)
        let hexColor = String(hex[start...])

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = 1
            
            if hexColor.count > 6 {
                a = CGFloat(hexNumber & 0x000000ff) / 255
            }
            
            self.init(red: r, green: g, blue: b, alpha: a)
            
            return
        }

        return nil
    }
    
}
