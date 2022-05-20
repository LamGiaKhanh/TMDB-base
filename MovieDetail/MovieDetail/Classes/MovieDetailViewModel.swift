//
//  MovieDetailViewModel.swift
//  MovieDetail
//
//  Created by ExecutionLab's Macbook on 17/05/2022.
//

import Foundation
import Combine
import Core
import Domain

public protocol MovieDetailViewModel: ViewModel, Stepper {
    var movie: Movie { get set }
}

public class MovieDetailViewModelImpl: MovieDetailViewModel, ObservableObject {
    @Injected var movieDetailUseCase: MovieDetailUseCase
    
    @Published public var movie: Movie
    
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
    
    deinit {
        print("MovieDetailViewModelImpl deinit")
    }

    public init(movie: Movie) {
        self.movie = movie
    }
    
}
