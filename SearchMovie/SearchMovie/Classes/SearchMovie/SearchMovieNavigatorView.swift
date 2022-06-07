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

public struct SearchMovieNavigatorView: View {
    @Store public var navigator: SearchMovieNavigator
    @EnvironmentObject var tabState: TabState
    
    public init(navigator: SearchMovieNavigator) {
        _navigator = Store(wrappedValue: navigator)
    }
    
    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            NavigationView {
                SearchMovieView(viewModel: navigator.searchMovieViewModel)
                    .id(navigator.rootViewId)
                    .hideNavigationBar()
                    .navigation(model: $navigator.movieDetailNavigator) {
                       MovieDetailNavigatorView(navigator: $0)
                            .hideNavigationBar()
                    }
            }
        }
        .navigationViewStyle(.stack)
    }
}
