//
//  AuthenticationCoordinator.swift
//  App
//
//  Created by ExecutionLab's Macbook on 26/05/2022.
//

import Foundation
import SwiftUI
import Stinsen
import Core

final class AuthenticatedCoordinator: NavigationCoordinatable {
    let stack = NavigationStack(initial: \AuthenticatedCoordinator.start)
    
    @Root var start = makeStart
    
    deinit {
        print("Deinit UnauthenticatedCoordinator")
    }
}

extension AuthenticatedCoordinator: Resolving {
    @ViewBuilder func makeStart() -> some View {
        LoginView(viewModel: resolve(LoginViewModel.self))
    }
}
