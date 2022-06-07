//
//  MovieCreditsUseCase.swift
//  Domain
//
//  Created by ExecutionLab's Macbook on 24/05/2022.
//

import Foundation
import Combine
import Core

public class MovieCreditsUseCase: CombineUseCase {
    @Injected var movieService: MovieService
    
    public typealias Input = String
    public typealias Output = CreditResponse
    public typealias Failure = MovieError

    public init() {}
    
    public func callAsFunction(_ input: String) -> AnyPublisher<CreditResponse, MovieError> {
        return movieService.fetchCredit(id: input)
            .eraseToAnyPublisher()
    }
}

