//
//  DashboardNavigator.swift
//  DashboardTab
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Combine
import Core
import Domain
import MovieDetail

public protocol DashboardNavigator: NavigatorModel, Stepper {
    var dashboardViewModel: DashboardViewModel { get set }
    
    var isShowTestViewWithoutViewModel: Bool { get set }
    var testViewModel: TestViewModel! { get set }
    var movieDetailViewModel: MovieDetailViewModel! { get set }
}

public enum DashboardStep: Step {
    case testView
    case testViewWithoutViewModel
    case logout
    case switchTab(Int)
    case movieDetail(Movie)
}

public class DashboardNavigatorImpl: DashboardNavigator, ObservableObject, Resolving {
    @Injected public var dashboardViewModel: DashboardViewModel
    public var cancellables = Set<AnyCancellable>()
    public var steps = PassthroughSubject<Step, Never>()
    
    @Published public var testViewModel: TestViewModel!
    @Published public var movieDetailViewModel: MovieDetailViewModel!
    
    @Published public var isShowTestViewWithoutViewModel: Bool = false

    public init() {
        contribute(dashboardViewModel)
    }
    
    public func go(to step: Step) {
        guard let step = step as? DashboardStep else { return }
        
        switch step {
        case .testView:
            testViewModel = resolve(TestViewModel.self)
        case .testViewWithoutViewModel:
            isShowTestViewWithoutViewModel = true
        case .switchTab, .logout:
            steps.send(step)
        case .movieDetail(let movie):
            movieDetailViewModel = resolve(MovieDetailViewModel.self, argument: movie)
        }
    }
}
