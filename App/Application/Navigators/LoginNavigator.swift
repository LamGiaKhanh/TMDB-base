//
//  LoginNavigator.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Core
import Combine

protocol LoginNavigator: NavigatorModel, Stepper {
    var loginViewModel: LoginViewModel { get }
}

enum LoginStep: Step {
    case home
}

class LoginNavigatorImpl: LoginNavigator, ObservableObject, Resolving {
    @Injected var loginViewModel: LoginViewModel

    var cancellables = Set<AnyCancellable>()
    let steps = PassthroughSubject<Step, Never>()

    init() {
        contribute(loginViewModel)
    }

    func go(to step: Step) {
        guard let step = step as? LoginStep else { return }

        switch step {
        case .home:
            steps.send(ContentStep.home)
        }
    }
}
