//
//  TMDBApp.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core

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
    }

    var body: some Scene {
        WindowGroup {
            ContentNavigatorView(navigator: contentNavigator)
        }
    }
}
