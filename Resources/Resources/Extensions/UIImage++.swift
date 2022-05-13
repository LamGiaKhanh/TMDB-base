//
//  UIImage++.swift
//  Common
//
//  Created by Phat Le on 08/04/2022.
//

import SwiftUI

public extension UIImage {
    static func load(_ name: String, bundle: Bundle? = nil) -> UIImage {
        return UIImage(named: name, in: bundle, compatibleWith: nil) ?? UIImage()
    }
}
