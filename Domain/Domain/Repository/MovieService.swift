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
    func fetchMovie(id: String) -> AnyPublisher<Movie, MovieError>
    func fetchRecommendations(id: String) -> AnyPublisher<MovieListResponse, MovieError>
    func fetchMovieByCategory(category: MovieCategory) -> AnyPublisher<MovieListResponse, MovieError>
}

public enum MovieCategory {
    case nowPlaying
    case upcoming
    case topRated
    case popular
}

public enum MovieError: String, Error {
    case nowPlaying
    case popular
    case upcoming
    case topRated
    case searchMovie
    case fetchMovie
    case fetchRecommendations
    case outOfTarget
}
