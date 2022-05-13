//
//  LoginView.swift
//  App
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import SwiftUI
import Core
import Resources

struct LoginView: View {
    @Store var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            ColorfulView()
            VStack(spacing: 4) {
                Text("IMDB")
                    .font(.system(size: 60, weight: .heavy, design: .default))
                    .italic()
                HStack(spacing: 0){
                    Text("Username")
                        .padding()
                        .frame(minWidth: 120)
                    TextField("Username", text: $viewModel.username)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 32)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 0.2)
                        )
                        .cornerRadius(8)
                }
                
                HStack(spacing: 0) {
                    Text("Password")
                        .padding()
                        .frame(minWidth: 120)
                    TextField("Password", text: $viewModel.password)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 32)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 0.2)
                        )
                        .cornerRadius(8)
                }
                
                Button(action: {
                    viewModel.signIn()
                }) {
                    Text("SIGN IN")
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                }
                .buttonStyle(GrowingButton())
                .frame(maxWidth: .infinity)
                .background(Color.yellow) // If you have this
                .cornerRadius(25)
            }.padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModelImpl())
    }
}
