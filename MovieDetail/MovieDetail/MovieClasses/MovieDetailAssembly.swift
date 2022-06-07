//
//  MovieDetailAssembly.swift
//  MovieDetail
//
//  Created by ExecutionLab's Macbook on 17/05/2022.
//

import Swinject
import Core
import Domain

public class MovieDetailAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(MovieDetailViewModel.self) { (r, movie: Movie) in
            MovieDetailViewModelImpl(movie: movie)
        }
        
        container.register(MovieDetailNavigator.self) { (r, movie: Movie, isRootView: Bool) in
            MovieDetailNavigatorImpl(movie: movie, isRootView: isRootView)
        }
    }
    
    public init() { }
}

