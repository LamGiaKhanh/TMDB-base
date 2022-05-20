//
//  SplashViewModel.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Domain
import Core

protocol SplashViewModel: ViewModel, Stepper {
    func checkLogin()
}

class SplashViewModelImpl: SplashViewModel, ObservableObject {
    var cancellables = Set<AnyCancellable>()
    let steps = PassthroughSubject<Step, Never>()

    @Injected var tokenService: TokenService

    deinit {
        print("SplashViewModelImpl deinit")
    }

    func checkLogin() {
        steps.send(ContentStep.home)
    }
}
