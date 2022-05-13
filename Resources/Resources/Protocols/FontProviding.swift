//
//  FontProviding.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import SwiftUI

public protocol FontProviding {
    var fontName: String { get }
}

public extension FontProviding where Self: RawRepresentable, Self.RawValue == String {
    var fontName: String { rawValue }
}

public extension FontProviding {
    func callAsFunction(size: CGFloat) -> Font {
        Font.custom(fontName, size: size)
    }

    func callAsFunction(size: CGFloat) -> UIFont {
        UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    }
}
