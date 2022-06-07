//
//  FetchSimilarMovieUseCase.swift
//  Domain
//
//  Created by ExecutionLab's Macbook on 01/06/2022.
//

import Foundation
import Combine
import Core

public class FetchSimilarMovieUseCase: CombineUseCase {
    @Injected var movieService: MovieService
    
    public typealias Input = String
    public typealias Output = MovieListResponse
    public typealias Failure = MovieError

    public init() {}
    
    public func callAsFunction(_ input: String) -> AnyPublisher<MovieListResponse, MovieError> {
        return movieService.fetchSimilarMovies(id: input)
            .eraseToAnyPublisher()
    }
}
