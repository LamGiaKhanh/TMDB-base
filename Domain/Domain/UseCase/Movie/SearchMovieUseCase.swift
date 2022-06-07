//
//  SearchMovieUseCase.swift
//  Domain
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Core

public class SearchMovieUseCase: CombineUseCase {
    @Injected var movieService: MovieService
    
    public typealias Input = String
    public typealias Output = MovieListResponse
    public typealias Failure = MovieError

    public init() {}
    
    public func callAsFunction(_ input: String) -> AnyPublisher<MovieListResponse, MovieError> {
        return movieService.searchMovie(input: input)
            .eraseToAnyPublisher()
    }
}
