//
//  ColorProviding.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import SwiftUI

public protocol ColorProviding {
    var hexColor: String { get }
}

public extension ColorProviding where Self: RawRepresentable, Self.RawValue == String {
    var hexColor: String { rawValue }
}

public extension ColorProviding {
    func callAsFunction() -> Color {
        .init(stringLiteral: hexColor)
    }

    func callAsFunction() -> UIColor {
        .init(hexString: hexColor)
    }
}
