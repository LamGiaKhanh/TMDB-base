//
//  MainCoordinator.swift
//  App
//
//  Created by ExecutionLab's Macbook on 26/05/2022.
//

import Foundation
import SwiftUI
import Stinsen
import DashboardTab
import SearchMovie

final class MainCoordinator: NavigationCoordinatable {
    var stack: NavigationStack<MainCoordinator>
    
    @Root var unauthenticated = makeUnauthenticated
    @Root var authenticated = makeAuthenticated
    
    @ViewBuilder func sharedView(_ view: AnyView) -> some View {
        view
            .onReceive(AuthenticationService.shared.$status, perform: { status in
                switch status {
                case .unauthenticated:
                    self.root(\.unauthenticated)
                case .authenticated:
                    self.root(\.authenticated)
                }
            })
            .hideNavigationBar()
            
    }
    
    deinit {
        print("Deinit MainCoordinator")
    }
    
    init() {
        switch AuthenticationService.shared.status {
        case .authenticated(let user):
            stack = NavigationStack(initial: \MainCoordinator.authenticated, user)
        case .unauthenticated:
            stack = NavigationStack(initial: \MainCoordinator.unauthenticated)
        }
    }
}

extension MainCoordinator {
    func makeUnauthenticated() -> NavigationViewCoordinator<AuthenticatedCoordinator> {
        return NavigationViewCoordinator(AuthenticatedCoordinator())
    }
    
    func makeAuthenticated(user: User) -> DashboardCoordinator {
        return DashboardCoordinator()
    }
}
