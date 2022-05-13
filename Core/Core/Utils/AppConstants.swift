//
//  AppConstants.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import SwiftUI

public enum AppConstants {
    public static let screenSize: CGSize = UIScreen.main.bounds.size
    public static let safeAreaInsets = UIApplication.shared.windows.first { $0.isKeyWindow }?.safeAreaInsets ?? .zero
    public static let navBarHeight: CGFloat = 45
    public static let topInsetWithNavBar: CGFloat = navBarHeight + safeAreaInsets.top
    public static let environmentMode: String = (Bundle.main.infoDictionary?["Environment"] as? String) ?? "Development"
}
