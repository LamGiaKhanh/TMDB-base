//
//  TMDBApp.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core
import Resources

@main
struct TMDBApp: App, Resolving {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate

    lazy var initializers: [Initializable] = [
        DIInitializer(), // must be the first item
        CommonInitializer(),
        AmplifyInitialzer()
    ]

    @Store var contentNavigator: ContentNavigator!

    init() {
        initializers.forEach { $0.performInitialization() }
        _contentNavigator = Store(wrappedValue: ContentNavigatorImpl())
        
        let standardAppearance = UITabBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UITabBar.appearance().standardAppearance = standardAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = standardAppearance
        } else {
            UITabBar.appearance().standardAppearance = standardAppearance
        }
        UINavigationBar.appearance().tintColor = R.color.steam_gold()!
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some Scene {
        WindowGroup {
            ContentNavigatorView(navigator: contentNavigator)
        }
    }
}
