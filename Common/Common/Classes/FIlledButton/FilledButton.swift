//
//  FilledButton.swift
//  Common
//
//  Created by ExecutionLab's Macbook on 19/05/2022.
//

import Foundation
import SwiftUI
import Resources

public enum ButtonSize {
    case small
    case medium
    case large
    
    var height: CGFloat {
        switch self {
        case .small:
            return 32
        case .medium:
            return 44
        case .large:
            return 52
        }
    }
    
    var titleSize: CGFloat {
        switch self {
        case .small:
            return 16
        case .medium:
            return 18
        case .large:
            return 24
        }
    }
}

public struct FilledButton: View {
    let title: String
    let action: () -> Void
    let height: CGFloat
    let fontSize: CGFloat
    
    @State private var buttonSize = CGSize()
    
    public init(buttonType: ButtonSize = .medium, _ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.height = buttonType.height
        self.fontSize = buttonType.titleSize
    }

    public var body: some View {
        Button(title, action: action)
            .font(R.font.fjallaOneRegular.font(size: fontSize))
            .foregroundColor(.white)
            .padding()
            .background(R.color.steam_gold.color)
            .frame(height: height)
            .readSize(onChange: { size in
                buttonSize = size
            })
            .shadow(color: R.color.steam_white.color, radius: buttonSize.height / 6, x: -2, y: 2)
            .cornerRadius(buttonSize.height / 2)
    }
}

public struct TransparentButton: View {
    let action: () -> Void
    let size: CGFloat
    let fontSize: CGFloat
    let image: Image?
    
    @State private var buttonSize = CGSize()
    
    public init(buttonType: ButtonSize = .medium, image: Image? = nil, action: @escaping () -> Void) {
        self.image = image
        self.size = buttonType.height
        self.fontSize = buttonType.titleSize
        self.action = action
    }

    public var body: some View {
        Button(action: action, label: {
            image
        })
            .font(R.font.fjallaOneRegular.font(size: fontSize))
            .padding()
            .frame(width: size, height: size)
            .contentShape(Rectangle())
            .readSize(onChange: { size in
                buttonSize = size
            })
    }
}
