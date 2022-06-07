//
//  SearchCoordinator.swift
//  App
//
//  Created by ExecutionLab's Macbook on 26/05/2022.
//

import Foundation
import Stinsen
import SwiftUI
import Core

final public class SearchCoordinator: NavigationCoordinatable {
    public let stack = NavigationStack(initial: \SearchCoordinator.start)
    @Root var start = makeStart
    
    public init() { }

    deinit {
        print("Deinit SearchCoordinator")
    }
    
}

extension SearchCoordinator: Resolving {
    @ViewBuilder func makeStart() -> some View {
        SearchMovieView(viewModel: resolve(SearchMovieViewModel.self))
            .hideNavigationBar()
    }
}
