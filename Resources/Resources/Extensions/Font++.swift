//
//  Font++.swift
//  Resources
//
//  Created by ExecutionLab's Macbook on 16/05/2022.
//

import Foundation
import SwiftUI

public struct TitleFont: ViewModifier {
    let size: CGFloat
    
    
    public func body(content: Content) -> some View {
        return content.font(R.font.fjallaOneRegular.font(size: size))
    }
}

public extension View {
    public func titleFont(size: CGFloat) -> some View {
        return ModifiedContent(content: self, modifier: TitleFont(size: size))
    }
    
    public func titleStyle() -> some View {
        return ModifiedContent(content: self, modifier: TitleFont(size: 16))
    }
}
