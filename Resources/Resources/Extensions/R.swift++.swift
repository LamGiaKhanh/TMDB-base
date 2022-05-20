//
//  R.swift++.swift
//  Resources
//
//  Created by ExecutionLab's Macbook on 17/05/2022.
//

import Rswift
import SwiftUI

public extension FontResource {
    func font(size: CGFloat) -> Font {
        Font.custom(fontName, size: size)
    }
}

public extension ColorResource {
    var color: Color {
        Color(name, bundle: bundle)
    }
}

public extension StringResource {
    var localizedStringKey: LocalizedStringKey {
        LocalizedStringKey(key)
    }

    var text: Text {
        Text(localizedStringKey)
    }
}

public extension ImageResource {
    var image: Image {
        Image(name, bundle: bundle)
    }
}
