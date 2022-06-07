//
//  HomeNavigatorView.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core
import Resources
import DashboardTab
import SearchMovie
import Introspect
import Combine

struct HomeNavigatorView: View {
    @Store var navigator: HomeNavigator
    @State public var tabState = TabState()
    
    let appearance: UITabBarAppearance = UITabBarAppearance()

    var body: some View {
        TabView(selection: $navigator.tabSelected) {
            DashboardNavigatorView(navigator: navigator.dashboardNavigator)
                .modifier(TabItem(.home))
            SearchMovieNavigatorView(navigator: navigator.searchNavigator)
                .modifier(TabItem(.search))
        }
        .introspectTabBarController(customize: { (UITabBarController) in
            UITabBarController.tabBar.isHidden = tabState.hideTabView
        })
        .accentColor(R.color.steam_gold.color)
        .environmentObject(tabState)
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
    
    var image: Image {
        switch self {
        case .home:
            return R.image.ic_rehearsal.image
        case .search:
            return R.image.icon_search1.image
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
                    item.image.renderingMode(.template)
                }
            }
            .tag(item)
    }
}
