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
import SwiftUI

public protocol MovieDetailNavigator: NavigatorModel, Core.Stepper {
    var movieDetailViewModel: MovieDetailViewModel! { get set }
    var initMovie: Movie { get set }
    var isRootView: Bool { get set }
    var testViewModel: TestViewModel! { get set }
    var testViewModel1: TestViewModel! { get set }
    var testViewModel2: TestViewModel! { get set }
    
    var duplicateMovieDetailNavigator: MovieDetailNavigator! { get set }
    var presentedList: [Binding<Bool>] { get set }
}

public enum MovieDetailStep: Step {
    case movieDetail(Movie)
    case popToRoot
    case dismiss
    case testView
    case testView1
    case testView2
}

public class MovieDetailNavigatorImpl: MovieDetailNavigator, ObservableObject, Resolving {
    
    @Published public var movieDetailViewModel: MovieDetailViewModel!
    @Published public var duplicateMovieDetailNavigator: MovieDetailNavigator!
    @Published public var initMovie: Movie
    @Published public var isRootView: Bool
    @Published public var testViewModel: TestViewModel!
    @Published public var testViewModel1: TestViewModel!
    @Published public var testViewModel2: TestViewModel!
    
    public var presentedList: [Binding<Bool>] = []
    public var cancellables = Set<AnyCancellable>()
    public var steps = PassthroughSubject<Step, Never>()
    
    public init(movie: Movie, isRootView: Bool) {
        self.initMovie = movie
        self.isRootView = isRootView
        self.movieDetailViewModel = resolve(MovieDetailViewModel.self, argument: movie)
        contribute(movieDetailViewModel)
    }
    
    public func go(to step: Step) {
        guard let step = step as? MovieDetailStep else {
            return
        }
        
        switch step {
        case .testView:
            testViewModel = resolve(TestViewModel.self)
            contribute(testViewModel)
        case .testView1:
            testViewModel1 = resolve(TestViewModel.self)
            contribute(testViewModel1)
        case .testView2:
            testViewModel2 = resolve(TestViewModel.self)
            contribute(testViewModel2)
        case .movieDetail(let movie):
            duplicateMovieDetailNavigator = resolve(MovieDetailNavigator.self, argument1: movie, argument2: false)
            contribute(duplicateMovieDetailNavigator)
        case .dismiss:
            dismiss(presentedList: presentedList)
        default:
            return
        }
    }
}
