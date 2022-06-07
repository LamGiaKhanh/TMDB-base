//
//  HomeCoordinator.swift
//  App
//
//  Created by ExecutionLab's Macbook on 26/05/2022.
//

import Foundation
import Stinsen
import SwiftUI
import Core

final public class HomeCoordinator: NavigationCoordinatable {
    public let stack = NavigationStack(initial: \HomeCoordinator.start)
    @Root var start = makeStart
    
    public init() { }
    
    deinit {
        print("Deinit UnauthenticatedCoordinator")
    }
    
}
extension HomeCoordinator: Resolving {
    @ViewBuilder func makeStart() -> some View {
        DashboardView(viewModel: resolve(DashboardViewModel.self))
            .hideNavigationBar()
            .background(Color.black.ignoresSafeArea())
    }
}
