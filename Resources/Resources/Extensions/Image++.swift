//
//  Image++.swift
//  Common
//
//  Created by Phat Le on 08/04/2022.
//

import SwiftUI

public extension Image {
    static func load(_ name: String, bundle: Bundle? = nil) -> Image {
        return Image(name, bundle: bundle)
    }
}
