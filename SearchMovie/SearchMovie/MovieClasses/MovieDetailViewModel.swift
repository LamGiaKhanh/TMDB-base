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

public protocol MovieDetailViewModel: LoadableViewModel, Stepper {
    var movie: Movie { get set }
    var recommendationList: [Movie] { get set }
    
    var castList: [Cast] { get set }
    var crewList: [Cast] { get set }
    
    func fetchRecommendation(with movieId: String) -> AnyCancellable
    func fetchCredits(with movieId: String) -> AnyCancellable
    func chainingFetch(with movieId: String)
}

public class MovieDetailViewModelImpl: MovieDetailViewModel, ObservableObject {
    @Injected var movieDetailUseCase: MovieDetailUseCase
    @Injected var movieRecommendationUseCase: MovieRecommendationsUseCase
    @Injected var movieCreditsUsecase: MovieCreditsUseCase

    @Published public var movie: Movie
    @Published public var recommendationList: [Movie] = []
    @Published public var castList: [Cast] = []
    @Published public var crewList: [Cast] = []
    @Published public var viewModelState: LoadableState = .idle
    
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
        
    deinit {
        print("MovieDetailViewModelImpl deinit")
    }

    public init(movie: Movie) {
        self.movie = movie
    }
    
    public func fetchRecommendation(with movieId: String) -> AnyCancellable {
        return movieRecommendationUseCase(movieId).sink(receiveCompletion: { _ in }) { [weak self] result in
            self?.recommendationList = result.movies
        }
    }
    
    public func fetchCredits(with movieId: String) -> AnyCancellable {
        return movieCreditsUsecase(movieId).sink { _ in
        } receiveValue: { [weak self] result in
            self?.castList = result.cast
            self?.crewList = result.crew
        }
    }
    
    public func chainingFetch(with movieId: String) {
        viewModelState = .loading
        Publishers.Zip(movieCreditsUsecase(movieId), movieRecommendationUseCase(movieId))
            .sink { _ in
            } receiveValue: { [weak self] creditResponse, recommendationResponse in
                self?.castList = creditResponse.cast
                self?.crewList = creditResponse.crew
                self?.recommendationList = recommendationResponse.movies
                self?.viewModelState = .loaded
            }
            .store(in: &cancellables)
    }
}
