//
//  SplashView.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core
import Resources
import Common

struct SplashView: View {
    @Store var viewModel: SplashViewModel

    var body: some View {
        ZStack {
            ColorfulView()
            Text("Splash view")
                .font(.largeTitle)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.viewModel.checkLogin()
                    }
                }
        }
       
    }
}
