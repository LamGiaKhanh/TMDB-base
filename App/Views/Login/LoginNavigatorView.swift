//
//  LoginNavigatorView.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core

struct LoginNavigatorView: View {
    @Store var navigator: LoginNavigator
    
    var body: some View {
        NavigationView {
            LoginView(viewModel: navigator.loginViewModel)
                .hideNavigationBar()
        }.navigationViewStyle(.stack)
    }
}
