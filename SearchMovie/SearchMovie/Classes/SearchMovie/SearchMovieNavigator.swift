//
//  SearchNavigator.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Core
import Domain

public protocol SearchMovieNavigator: NavigatorModel, Stepper {
    var searchMovieViewModel: SearchMovieViewModel { get set }
    var movieDetailNavigator: MovieDetailNavigator! { get set }
    
    var rootViewId: UUID { get set }
}

public enum SearchMovieStep: Step {
    case movieDetail(Movie)
    case popToRoot
}

public class SearchMovieNavigatorImpl: SearchMovieNavigator, ObservableObject, Resolving {
    @Injected public var searchMovieViewModel: SearchMovieViewModel

    public var cancellables = Set<AnyCancellable>()
    public var steps = PassthroughSubject<Step, Never>()
    
    @Published public var movieDetailNavigator: MovieDetailNavigator!
    @Published public var rootViewId: UUID = .init()

    public init() {
        contribute(searchMovieViewModel)
    }
    
    public func go(to step: Step) {
        guard let step = step as? SearchMovieStep else { return }
        
        switch step {
        case .movieDetail(let movie):
            movieDetailNavigator = resolve(MovieDetailNavigator.self, argument1: movie, argument2: true)
            contribute(movieDetailNavigator)
        case .popToRoot:
            self.rootViewId = .init()
        }
    }
}
