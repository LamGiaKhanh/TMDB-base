//
//  HomeNavigator.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Core
import DashboardTab

protocol HomeNavigator: NavigatorModel, Stepper {
    var tabSelected: MainTab { get set }
    var dashboardNavigator: DashboardNavigator { get set }
}

enum HomeStep: Step {
    case setting
}

class HomeNavigatorImpl: HomeNavigator, ObservableObject {
    var cancellables = Set<AnyCancellable>()
    let steps = PassthroughSubject<Step, Never>()
    
    @Published var tabSelected: MainTab
    
    @Injected var dashboardNavigator: DashboardNavigator
    
    deinit {
        print("HomeNavigatorImpl deinit")
    }
    
    init() {
        tabSelected = .home
        contribute([
            dashboardNavigator
        ])
    }
    
    func go(to step: Step) {
        if let step = step as? DashboardStep {
            handleDashboardStep(step)
            return
        }
    }
    
    func handleDashboardStep(_ step: DashboardStep) {
        switch step {
        case .switchTab:
            tabSelected = .search
        case .logout:
            steps.send(ContentStep.login)
        default:
            return
        }
    }
}
