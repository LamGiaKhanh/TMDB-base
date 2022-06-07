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

public struct TmdbInfo {
    public static let apiKey = "02f4ea80210dac5addfcb95ec72a8b7c"
    public static let endpointUrl = "https://api.themoviedb.org/3"
}
