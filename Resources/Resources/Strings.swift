//
//  Strings.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import Foundation

public enum CommonStrings: String, Localizable {
    case appName = "app.name"
    case appVersion = "app.version"

    public var bundle: Bundle { .resources }
}
