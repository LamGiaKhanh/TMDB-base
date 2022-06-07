//
//  MovieDetailNavigator.swift
//  MovieDetail
//
//  Created by ExecutionLab's Macbook on 24/05/2022.
//

import Foundation
import Combine
import Core
import Domain

public protocol MovieDetailNavigator: NavigatorModel, Stepper {
    var movieDetailViewModel: MovieDetailViewModel! { get set }
    var initMovie: Movie { get set }
    var isRootView: Bool { get set }
    
    var duplicateMovieDetailNavigator: MovieDetailNavigator! { get set }
}

public enum MovieDetailStep: Step {
    case movieDetail(Movie)
    case popToRoot
}

public class MovieDetailNavigatorImpl: MovieDetailNavigator, ObservableObject, Resolving {
    
    @Published public var movieDetailViewModel: MovieDetailViewModel!
    @Published public var duplicateMovieDetailNavigator: MovieDetailNavigator!
    @Published public var initMovie: Movie
    @Published public var isRootView: Bool
    
    public var cancellables = Set<AnyCancellable>()
    public var steps = PassthroughSubject<Step, Never>()
    
    public init(movie: Movie, isRootView: Bool) {
        self.initMovie = movie
        self.isRootView = isRootView
        self.movieDetailViewModel = resolve(MovieDetailViewModel.self, argument: movie)
        contribute(movieDetailViewModel)
    }
    
    public func go(to step: Step) {
        if step is DashboardStep {
            forwardToParent(step)
            return
        }
        
        guard let step = step as? MovieDetailStep else { return }
        
        switch step {
        case .movieDetail(let movie):
            duplicateMovieDetailNavigator = resolve(MovieDetailNavigator.self, argument1: movie, argument2: false)
            contribute(duplicateMovieDetailNavigator)
        default:
            return
        }
    }
}
