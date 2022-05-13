//
//  Fonts.swift
//  Common
//
//  Created by Phat Le on 07/04/2022.
//

import SwiftUI

public func registerCommonFonts() {
    let fontFile = Bundle.resources.path(forResource: "MotionPicture", ofType: "ttf")
    UIFont.register(resource: fontFile)
}

public enum AppFonts: String, FontProviding {
    case motionPicture = "MotionPicturePersonalUse"
}
