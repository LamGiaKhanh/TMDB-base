//
//  DashboardView.swift
//  DashboardTab
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core
import Resources

struct DashboardView: View {
    @Store public var viewModel: DashboardViewModel
    
    public init(viewModel: DashboardViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            Text("Dashboard Main view")
            Text(CommonStrings.appName())
            CommonImages.abc()
            Button("Push test view") {
                viewModel.steps.send(DashboardStep.testView)
            }
            Button("Show test view") {
                viewModel.steps.send(DashboardStep.testViewWithoutViewModel)
            }
            Button("Go to tab 2") {
                viewModel.steps.send(DashboardStep.switchTab(2))
            }
        }
        .matchParent()
        .overlay(
            Button("Logout") {
                viewModel.logout()
            }.padding(),
            alignment: .topTrailing
        )
    }
}

struct TestViewWithoutViewModel: View {
    var body: some View {
        VStack {
            Text("TestView without Viewmodel")
        }
    }
}

public protocol TestViewModel: ViewModel {
    
}

class TestViewModelImpl: TestViewModel, ObservableObject {
    
}

struct TestViewWithViewModel: View {
    @Store var viewModel: TestViewModel
    
    var body: some View {
        VStack {
            Text("TestView with ViewModel")
        }
    }
}
