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
import Resources

struct SearchMovieView: View {
    @Store public var viewModel: SearchMovieViewModel
    
    @State private var query: String = ""
    @State private var isSearching = false

    public init(viewModel: SearchMovieViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    public var body: some View {
        List {
            SearchField(
                searchTextWrapper: viewModel as! SearchTextObservable,
                placeholder: "Search any movies",
                isSearching: $isSearching,
                dismissButtonCallback: {
                    viewModel.movieList = []
                }
            )
                .onPreferenceChange(OffsetTopPreferenceKey.self) { value in
                    print("onPreferenceChange \(value)")
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            if isSearching {
                ForEach(viewModel.movieList) { movie in
                    MovieRow(movie: movie)
                }
                .transition(.move(edge: .leading))
            }
        }
        .edgesIgnoringSafeArea(.leading)
    }
}
