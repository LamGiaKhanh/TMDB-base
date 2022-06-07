//
//  MovieDetailNavigatiorView.swift
//  MovieDetail
//
//  Created by ExecutionLab's Macbook on 24/05/2022.
//

import Foundation
import SwiftUI
import Core
import Resources

public struct MovieDetailNavigatorView: View {
    @Store public var navigator: MovieDetailNavigator
    
    public init(navigator: MovieDetailNavigator) {
        _navigator = Store(wrappedValue: navigator)
    }
    
    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            NavigationView {
                MovieDetailView(viewModel: navigator.movieDetailViewModel, isRootView: navigator.isRootView)
                    .hideNavigationBar()
                    .navigation(model: $navigator.duplicateMovieDetailNavigator) {
                        MovieDetailNavigatorView(navigator: $0)
                            .hideNavigationBar()
                    }
            }
        }
        .navigationViewStyle(.stack)
    }
}
