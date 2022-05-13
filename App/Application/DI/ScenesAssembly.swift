//
//  ScenesAssembly.swift
//  StreamApp
//
//  Created by Phat Le on 29/04/2022.
//

import Core

class ScenesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SplashViewModel.self) { r in
            SplashViewModelImpl()
        }

        container.register(HomeNavigator.self) { r in
            HomeNavigatorImpl()
        }
        
        container.register(LoginNavigator.self) { r in
            LoginNavigatorImpl()
        }

        container.register(LoginViewModel.self) { r in
            LoginViewModelImpl()
        }
    }
}
