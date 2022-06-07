//
//  DashboardTabAssembly.swift
//  DashboardTab
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Core
import Domain

public class DashboardTabAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(DashboardNavigator.self) { r in
            DashboardNavigatorImpl()
        }
        
        container.register(DashboardViewModel.self) { r in
            DashboardViewModelImpl()
        }
        
        container.register(TestViewModel.self) { r in
            TestViewModelImpl()
        }
        
        container.register(MovieDetailViewModel.self) { (r, movie: Movie) in
            MovieDetailViewModelImpl(movie: movie)
        }
        
        container.register(MovieDetailNavigator.self) { (r, movie: Movie, isRootView: Bool) in
            MovieDetailNavigatorImpl(movie: movie, isRootView: isRootView)
        }
    }
}
