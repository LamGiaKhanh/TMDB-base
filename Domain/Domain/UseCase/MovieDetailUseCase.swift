//
//  MovieDetailUseCase.swift
//  Domain
//
//  Created by ExecutionLab's Macbook on 17/05/2022.
//

import Foundation
import Combine
import Core

public class MovieDetailUseCase: CombineUseCase {
    @Injected var movieService: MovieService
    
    public typealias Input = String
    public typealias Output = Movie
    public typealias Failure = MovieError

    public init() {}
    
    public func callAsFunction(_ input: String) -> AnyPublisher<Movie, MovieError> {
        return movieService.fetchMovie(id: input)
            .eraseToAnyPublisher()
    }
}
