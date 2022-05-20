//
//  SearchNavigator.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Core
import MovieDetail
import Domain

public protocol SearchMovieNavigator: NavigatorModel, Stepper {
    var searchMovieViewModel: SearchMovieViewModel { get set }
    var movieDetailViewModel: MovieDetailViewModel! { get set}
}

public enum SearchMovieStep: Step {
    case movieDetail(Movie)
}

public class SearchMovieNavigatorImpl: SearchMovieNavigator, ObservableObject, Resolving {
    @Injected public var searchMovieViewModel: SearchMovieViewModel

    public var cancellables = Set<AnyCancellable>()
    public var steps = PassthroughSubject<Step, Never>()
    
    @Published public var movieDetailViewModel: MovieDetailViewModel!

    public init() {
        contribute(searchMovieViewModel)
    }
    
    public func go(to step: Step) {
        guard let step = step as? SearchMovieStep else { return }
        
        switch step {
        case .movieDetail(let movie):
            movieDetailViewModel = resolve(MovieDetailViewModel.self, argument: movie)
        }
    }
}
