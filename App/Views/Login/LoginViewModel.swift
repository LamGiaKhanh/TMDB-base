//
//  LoginViewModel.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Domain
import Core

protocol LoginViewModel: ViewModel, Stepper {
    var username: String { get set }
    var password: String { get set }
    
    func signIn()
}

class LoginViewModelImpl: LoginViewModel, ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Injected var loginUseCase: AuthenticateUseCase
    
    var cancellables = Set<AnyCancellable>()
    let steps = PassthroughSubject<Step, Never>()
    
    deinit {
        print("LoginViewModelImpl deinit")
    }
    
    func signIn() {
        self.steps.send(LoginStep.home)
//        loginUseCase(.init(username: username,
//                           password: password,
//                           clientMetaData: [:]))
//            .receive(on: RunLoop.main)
//            .sink { r in
//
//            } receiveValue: { [weak self] data in
//                print("@@@@ \(data)")
//                self?.steps.send(LoginStep.home)
//            }.store(in: &cancellables)
    }
}
