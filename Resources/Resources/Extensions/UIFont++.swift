//
//  UIFont++.swift
//  Common
//
//  Created by Phat Le on 07/04/2022.
//

import SwiftUI

extension UIFont {
    static func register(resource: String?) {
        guard let resource = resource,
              let fontData = NSData(contentsOfFile: resource),
              let dataProvider = CGDataProvider.init(data: fontData) else {
                  print("Register -\(resource ?? "nil")- font error: invalid resource")
                  return
              }
        guard let fontRef = CGFont.init(dataProvider) else {
            print("Register -\(resource)- font error: can not create font")
            return
        }
        var errorRef: Unmanaged<CFError>? = nil
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else {
            print("Register -\(resource)- font error: can not register font")
            return
        }
    }

    var swiftUI: Font {
        return Font(self)
    }
}
