//
//  UIColor++.swift
//  Common
//
//  Created by Phat Le on 07/04/2022.
//

import SwiftUI

public extension UIColor {
    convenience init(hexString hex: String) {
        let value = hex.uppercased()
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        let start = value.index(value.startIndex, offsetBy: value.hasPrefix("#") ? 1 : 0)
        var hexColor = String(value[start...])
        if hexColor.count == 6 {
            hexColor.append("FF") // alpha = 1
        }
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        let mask: UInt64 = 0x000000FF
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat(hexNumber >> 24 & mask) / 255.0
            g = CGFloat(hexNumber >> 16 & mask) / 255.0
            b = CGFloat(hexNumber >> 8 & mask) / 255.0
            a = CGFloat(hexNumber & mask) / 255.0
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }

    var swiftUI: Color {
        return Color(self)
    }
}
