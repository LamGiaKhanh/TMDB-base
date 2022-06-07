//
//  MovieRecommendationsUseCase.swift
//  Domain
//
//  Created by ExecutionLab's Macbook on 18/05/2022.
//

import Foundation
import Combine
import Core

public class MovieRecommendationsUseCase: CombineUseCase {
    @Injected var movieService: MovieService
    
    public typealias Input = String
    public typealias Output = MovieListResponse
    public typealias Failure = MovieError

    public init() {}
    
    public func callAsFunction(_ input: String) -> AnyPublisher<MovieListResponse, MovieError> {
        return movieService.fetchRecommendations(id: input)
            .eraseToAnyPublisher()
    }
}

