//
//  ContentViwe.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core

struct ContentNavigatorView: View {
    @Store var navigator: ContentNavigator
    
    var body: some View {
        buildBody()
            .hideNavigationBar()
    }
}

private extension ContentNavigatorView {
    @ViewBuilder
    func buildBody() -> some View {
        switch navigator.viewType {
        case .home:
            HomeNavigatorView(navigator: navigator.homeNavigator)
        case .login:
            LoginNavigatorView(navigator: navigator.loginNavigator)
        case .splash:
            SplashView(viewModel: navigator.splashViewModel)
        }
    }
}

