//
//  SearchNavigator.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Core

public protocol SearchMovieNavigator: NavigatorModel, Stepper {
    var searchMovieViewModel: SearchMovieViewModel { get set }
}

public enum SearchMovieStep: Step {
    case initial
}

public class SearchMovieNavigatorImpl: SearchMovieNavigator, ObservableObject, Resolving {
    @Injected public var searchMovieViewModel: SearchMovieViewModel

    public var cancellables = Set<AnyCancellable>()
    public var steps = PassthroughSubject<Step, Never>()
    

    public init() {
        contribute(searchMovieViewModel)
    }
    
    public func go(to step: Step) {
        guard let step = step as? SearchMovieStep else { return }
        
        switch step {
        case .initial:
            return
        }
    }
}
