//
//  ContentNavigator.swift
//  StreamApp
//
//  Created by Phat Le on 27/04/2022.
//

import Foundation
import Core

protocol ContentNavigator: NavigatorModel {
    var splashViewModel: SplashViewModel! { get }
    var loginNavigator: LoginNavigator! { get }
    var homeNavigator: HomeNavigator! { get }
    var viewType: ContentViewType { get set }
}

enum ContentStep: Step {
    case home
    case login
}

enum ContentViewType {
    case splash
    case home
    case login
}

class ContentNavigatorImpl: ContentNavigator, ObservableObject, Resolving {
    @Injected var splashViewModel: SplashViewModel!
    @Published var homeNavigator: HomeNavigator!
    @Published var loginNavigator: LoginNavigator!
    @Published var viewType: ContentViewType = .splash

    init() {
        contribute(splashViewModel)
    }

    func go(to step: Step) {
        guard let step = step as? ContentStep else { return }

        switch step {
        case .login:
            homeNavigator = nil

            //
            viewType = .login
            loginNavigator = resolve(LoginNavigator.self)
            contribute(loginNavigator)
        case .home:
            loginNavigator = nil

            //
            viewType = .home
            homeNavigator = resolve(HomeNavigator.self)
            contribute(homeNavigator)
        }
    }
}
