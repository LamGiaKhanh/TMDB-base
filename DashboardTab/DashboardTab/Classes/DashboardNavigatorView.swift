//
//  DashboardNavigatorView.swift
//  DashboardTab
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core
import Resources

public struct DashboardNavigatorView: View {
    @Store public var navigator: DashboardNavigator
    
    public init(navigator: DashboardNavigator) {
        _navigator = Store(wrappedValue: navigator)
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                DashboardView(viewModel: navigator.dashboardViewModel)
                    .id(navigator.rootViewId)
                    .hideNavigationBar()
                    .sheet(isPresented: $navigator.isShowTestViewWithoutViewModel) {
                        TestViewWithoutViewModel()
                    }
                    .navigation(model: $navigator.testViewModel) {
                        TestViewWithViewModel(viewModel: $0)
                    }
                    .fullScreenCover(model: $navigator.movieDetailNavigator) {
                       MovieDetailNavigatorView(navigator: $0)
                    }
            }
        }.navigationViewStyle(.stack)
    }
}
