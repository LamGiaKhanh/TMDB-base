//
//  Color++.swift
//  Common
//
//  Created by Phat Le on 06/04/2022.
//

import SwiftUI

extension Color: ExpressibleByStringInterpolation {
    public static let bgColor = Color.black
    public static let textColor = Color.white
    public static let subTextColor = Color.white.opacity(0.7)
    public static let overlayColor = Color.gray.opacity(0.15)
    public static let buttonColor = Color(0xF79E44) // 0x6644B8
    public static let highlightColor = Color(0xF79E44)
    
    public static var steam_white: Color {
        Color("steam_white", bundle: nil)
    }
    
    public static var steam_gold: Color {
        Color("steam_gold", bundle: nil)
    }
    
    public static var steam_rust: Color {
        Color("steam_rust", bundle: nil)
    }
    
    public static var steam_rust2: Color {
        Color("steam_rust2", bundle: nil)
    }
    
    public static var steam_bronze: Color {
        Color("steam_bronze", bundle: nil)
    }
    
    public static var steam_brown: Color {
        Color("steam_brown", bundle: nil)
    }
    
    public static var steam_yellow: Color {
        Color("steam_yellow", bundle: nil)
    }
    
    public static var steam_blue: Color {
        Color("steam_blue", bundle: nil)
    }
    
    public static var steam_bordeaux: Color {
        Color("steam_bordeaux", bundle: nil)
    }
    
    public static var steam_green: Color {
        Color("steam_green", bundle: nil)
    }
    
    public static var steam_background: Color {
        Color("steam_background", bundle: nil)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(.init(hexString: value))
    }

    public var uiKit: UIColor {
        return UIColor(self)
    }

    public static func opacity(_ opacity: Double) -> StringLiteralType {
        let o = min(100, max(0, opacity)) * 255.0 / 100.0
        var hex = String(Int(o.rounded()), radix: 16).uppercased()
        if hex.count == 1 {
            hex = "0" + hex
        }
        return hex
    }
    
    public init(_ hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
