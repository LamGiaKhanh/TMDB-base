//
//  CommonInitializer.swift
//  StreamApp
//
//  Created by Phat Le on 12/04/2022.
//

import Foundation
import Core
import Resources
import IQKeyboardManagerSwift

class CommonInitializer: Initializable {
    func performInitialization() {
        registerCommonFonts()
        IQKeyboardManager.shared.enable = true
    }
}
