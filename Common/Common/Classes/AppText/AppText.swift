//
//  AppText.swift
//  Common
//
//  Created by ExecutionLab's Macbook on 19/05/2022.
//

import Foundation
import SwiftUI
import Resources

public enum TextType {
    case appTitle
    case largeTitle
    case title
    case content
    case movieTitle
    
    var size: CGFloat {
        switch self {
        case .appTitle:
            return 44
        case .largeTitle:
            return 36
        case .title:
            return 28
        case .content:
            return 13
        case .movieTitle:
            return 24
        }
    }
    
    var color: Color {
        switch self {
        case .largeTitle, .appTitle:
            return R.color.steam_gold.color
        case .content, .movieTitle, .title:
            return R.color.steam_rust2.color
        }
    }
}

public struct AppText: View {
    let title: String
    let type: TextType
    var action: (() -> Void)?
    
    public init(_ type: TextType = .title, _ title: String, action: (() -> Void)? = nil) {
        self.title = title
        self.type = type
        self.action = action
    }

    public var body: some View {
        Text(title)
            .font(R.font.fjallaOneRegular.font(size: type.size))
            .foregroundColor(type.color)
    }
}
