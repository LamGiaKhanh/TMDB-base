//
//  SearchMovieAssembly.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Core
import Domain

public class SearchMovieAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(SearchMovieNavigator.self) { r in
            SearchMovieNavigatorImpl()
        }
        
        container.register(SearchMovieViewModel.self) { r in
            SearchMovieViewModelImpl()
        }
        
        container.register(MovieDetailViewModel.self) { (r, movie: Movie) in
            MovieDetailViewModelImpl(movie: movie)
        }
        
        container.register(MovieDetailNavigator.self) { (r, movie: Movie, isRootView: Bool) in
            MovieDetailNavigatorImpl(movie: movie, isRootView: isRootView)
        }
        
        container.register(TestViewModel.self) { r in
            TestViewModelImpl()
        }
        
    }
}
