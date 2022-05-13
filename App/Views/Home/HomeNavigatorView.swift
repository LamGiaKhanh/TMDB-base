//
//  HomeNavigatorView.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core
import DashboardTab

struct HomeNavigatorView: View {
    @Store var navigator: HomeNavigator
    
    var body: some View {
        TabView(selection: $navigator.tabSelected) {
            DashboardNavigatorView(navigator: navigator.dashboardNavigator)
                .modifier(TabItem(.home))
            Text("Search")
                .modifier(TabItem(.search))
        }
    }
}

enum MainTab: Hashable {
    case home
    case search

    var name: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        }
    }
}

struct TabItem: ViewModifier {
    let item: MainTab
    
    init(_ item: MainTab) {
        self.item = item
    }
    
    func body(content: Content) -> some View {
        content
            .tabItem {
                VStack(alignment: .center) {
                    Text(item.name)
                }
            }
            .tag(item)
    }
}
