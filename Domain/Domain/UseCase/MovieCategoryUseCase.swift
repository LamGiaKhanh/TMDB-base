//
//  MovieCategoryUseCase.swift
//  Domain
//
//  Created by ExecutionLab's Macbook on 18/05/2022.
//

import Foundation
import Combine
import Core

public class MovieCategoryUseCase: CombineUseCase {
    @Injected var movieService: MovieService
    
    public typealias Input = MovieCategory
    public typealias Output = MovieListResponse
    public typealias Failure = MovieError

    public init() {}
    
    public func callAsFunction(_ input: MovieCategory) -> AnyPublisher<MovieListResponse, MovieError> {
        return movieService.fetchMovieByCategory(category: input)
            .eraseToAnyPublisher()
    }
}
