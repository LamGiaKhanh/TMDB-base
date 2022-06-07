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
    var recommendationList: [Movie] { get set }
    var similarList: [Movie] { get set }
    
    var castList: [Cast] { get set }
    var crewList: [Cast] { get set }
    
    func fetchRecommendation(movieId: String)
    func fetchCredits(movieId: String)
    func chainingFetch(with movieId: String)
}

public class MovieDetailViewModelImpl: MovieDetailViewModel, ObservableObject {
    @Injected var movieDetailUseCase: MovieDetailUseCase
    @Injected var movieRecommendationUseCase: MovieRecommendationsUseCase
    @Injected var movieCreditsUsecase: MovieCreditsUseCase
    @Injected var fetchSimilarMovieUseCase: FetchSimilarMovieUseCase

    @Published public var movie: Movie
    @Published public var recommendationList: [Movie] = []
    @Published public var similarList: [Movie] = []
    @Published public var castList: [Cast] = []
    @Published public var crewList: [Cast] = []

    
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
        
    deinit {
        print("MovieDetailViewModelImpl deinit")
    }

    public init(movie: Movie) {
        self.movie = movie
    }
    
    public func fetchRecommendation(movieId: String) {
        movieRecommendationUseCase(movieId).sink(receiveCompletion: { _ in }) { [weak self] result in
            self?.recommendationList = result.movies
        }
        .store(in: &cancellables)
    }
    
    public func fetchCredits(movieId: String) {
        movieCreditsUsecase(movieId).sink { _ in
        } receiveValue: { [weak self] result in
            self?.castList = result.cast
            self?.crewList = result.crew
        }.store(in: &cancellables)
    }
    
    public func chainingFetch(with movieId: String) {
        Publishers.Zip3(movieCreditsUsecase(movieId), movieRecommendationUseCase(movieId), fetchSimilarMovieUseCase(movieId))
            .sink { _ in
            } receiveValue: { [weak self] creditResponse, recommendationResponse, similarResponse in
                self?.castList = creditResponse.cast
                self?.crewList = creditResponse.crew
                self?.similarList = similarResponse.movies
                self?.recommendationList = recommendationResponse.movies
            }
            .store(in: &cancellables)
    }
}
