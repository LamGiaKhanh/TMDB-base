//
//  GrowingButton.swift
//  Resources
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI

public struct GrowingButton: ButtonStyle {
    public init() { }
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
