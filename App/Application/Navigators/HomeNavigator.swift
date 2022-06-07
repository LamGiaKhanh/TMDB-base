//
//  HomeNavigator.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import DashboardTab
import SearchMovie
import Domain
import Core
import Combine

protocol HomeNavigator: NavigatorModel, Stepper {
    var tabSelected: MainTab { get set }
    var dashboardNavigator: DashboardNavigator { get }
    var searchNavigator: SearchMovieNavigator { get }
}

enum HomeStep: Step {
    case setting
}

class HomeNavigatorImpl: HomeNavigator, ObservableObject, Resolving {
    
    var cancellables = Set<AnyCancellable>()
    let steps = PassthroughSubject<Step, Never>()
    
    @Published var tabSelected: MainTab
    
    @Injected var dashboardNavigator: DashboardNavigator
    @Injected var searchNavigator: SearchMovieNavigator
    
    
    deinit {
        print("HomeNavigatorImpl deinit")
    }
    
    init() {
        tabSelected = .home
        contribute([
            dashboardNavigator,
            searchNavigator
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
