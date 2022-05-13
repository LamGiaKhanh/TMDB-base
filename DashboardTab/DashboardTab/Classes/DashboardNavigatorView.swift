//
//  DashboardNavigatorView.swift
//  DashboardTab
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core

public struct DashboardNavigatorView: View {
    @Store public var navigator: DashboardNavigator
    
    public init(navigator: DashboardNavigator) {
        _navigator = Store(wrappedValue: navigator)
    }
    
    public var body: some View {
        NavigationView {
            DashboardView(viewModel: navigator.dashboardViewModel)
                .hideNavigationBar()
                .sheet(isPresented: $navigator.isShowTestViewWithoutViewModel) {
                    TestViewWithoutViewModel()
                }
                .navigation(model: $navigator.testViewModel) {
                    TestViewWithViewModel(viewModel: $0)
                }

        }.navigationViewStyle(.stack)
    }
}
