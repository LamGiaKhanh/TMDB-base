//
//  HomeCoordinator.swift
//  App
//
//  Created by ExecutionLab's Macbook on 26/05/2022.
//

import Foundation
import SwiftUI
import Stinsen
import Core
import DashboardTab
import SearchMovie

final class DashboardCoordinator: TabCoordinatable {
    var child = TabChild(
        startingItems: [
            \DashboardCoordinator.home,
             \DashboardCoordinator.search
        ]
    )
    
    @Route(tabItem: makeHomeTab) var home = makeHome
    @Route(tabItem: makeSearchTab) var search = makeSearch

    
    public init() { }
}

extension DashboardCoordinator {
    func makeHome()  -> NavigationViewCoordinator<HomeCoordinator> {
        return NavigationViewCoordinator(HomeCoordinator())
    }
    
    @ViewBuilder func makeHomeTab(isActive: Bool) -> some View {
        MainTab.home.image.renderingMode(.template)
        Text(MainTab.home.name)
    }
    
    func makeSearch()  -> NavigationViewCoordinator<SearchCoordinator> {
        return NavigationViewCoordinator(SearchCoordinator())
    }
    
    @ViewBuilder func makeSearchTab(isActive: Bool) -> some View {
        MainTab.search.image.renderingMode(.template)
        Text(MainTab.search.name)
    }
}

