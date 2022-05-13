//
//  DashboardViewModel.swift
//  DashboardTab
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Domain
import Core

public protocol DashboardViewModel: ViewModel, Stepper {
    func logout()
}

public class DashboardViewModelImpl: DashboardViewModel, ObservableObject {
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
    
    @Injected var logoutUseCase: LogOutUseCase
    
    public init() { }
    
    public func logout() {
        logoutUseCase().sink(receiveCompletion: { _ in }, receiveValue: { [weak self] _ in
            self?.steps.send(DashboardStep.logout)
        })
        .store(in: &cancellables)
    }
}
