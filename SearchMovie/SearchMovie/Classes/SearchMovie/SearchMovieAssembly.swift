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
    }
}
