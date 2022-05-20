//
//  SearchMovieNavigatorView.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import SwiftUI
import Core
import Resources
import MovieDetail

public struct SearchMovieNavigatorView: View {
    @Store public var navigator: SearchMovieNavigator
    
    public init(navigator: SearchMovieNavigator) {
        _navigator = Store(wrappedValue: navigator)
    }
    
    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            NavigationView {
                SearchMovieView(viewModel: navigator.searchMovieViewModel)
                    .hideNavigationBar()
                    .navigation(model: $navigator.movieDetailViewModel) {
                        MovieDetailView(viewModel: $0)
                    }
            }
        }
        .navigationViewStyle(.stack)
    }
}
