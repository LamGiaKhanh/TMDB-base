//
//  Fonts.swift
//  Common
//
//  Created by Phat Le on 07/04/2022.
//

import SwiftUI

public func registerCommonFonts() {
    let fontFile = Bundle.resources.path(forResource: "MotionPicture", ofType: "ttf")
    let titleFontFile = Bundle.resources.path(forResource: "FjallaOne-Regular", ofType: "ttf")
    
    UIFont.register(resource: fontFile)
    UIFont.register(resource: titleFontFile)
}

public enum AppFonts: String, FontProviding {
    case motionPicture = "MotionPicturePersonalUse"
    case fjallaOne = "FjallaOne"
}
