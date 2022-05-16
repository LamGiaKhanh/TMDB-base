//
//  SearchMovieService.swift
//  Domain
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine

public protocol MovieService {
    func searchMovie(input: String) -> AnyPublisher<MovieListResponse, MovieError>
}

public enum MovieError: Error {
    case searchMovie
}
