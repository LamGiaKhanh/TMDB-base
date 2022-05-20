//
//  OffsetTop.swift
//  Resources
//
//  Created by ExecutionLab's Macbook on 16/05/2022.
//

import SwiftUI

public struct OffsetTopPreferenceKey: PreferenceKey {
    static public var defaultValue: CGFloat = 0
    public typealias Value = CGFloat
    
    static public func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
