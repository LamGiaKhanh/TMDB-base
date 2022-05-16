//
//  SearchView.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import SwiftUI
import Core
import Combine

struct SearchMovieView: View {
    @Store public var viewModel: SearchMovieViewModel
    
    public init(viewModel: SearchMovieViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            Text("Searchmovie Main view")
                .onAppear {
                    viewModel.searchMovie(input: "marvel")
                }
        }
        .matchParent()
        
    }
}
