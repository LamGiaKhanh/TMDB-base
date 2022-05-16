//
//  SearchMovieServiceImpl.swift
//  Data
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Combine
import Domain
import Core
import TEQNetwork
import Alamofire


public class MovieServiceImpl: MovieService {
    @Injected var network: TEQNetwork
    var store = Set<AnyCancellable>()
    public init() {}
    
    
    public func searchMovie(input: String) -> AnyPublisher<MovieListResponse, MovieError> {
        let target = MovieTarget.searchMovie(input: input)
        return network.requestPublisher(targetType: target)
            .tryMap { movieList -> MovieListResponse in
                return movieList
            }
            .mapError { error -> MovieError in
                print("🌶🌶🌶 searchMovie error: \(error)")
                return .searchMovie
            }
            .eraseToAnyPublisher()
    }
}

public enum MovieTarget {
    case searchMovie(input: String)
}

extension MovieTarget: TargetType {
    public var apiKey: String {
        return "02f4ea80210dac5addfcb95ec72a8b7c"
    }

    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    public var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .searchMovie:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .searchMovie(let input):
            return .requestParameters(parameters: ["query": input, "api_key": apiKey], encoding: URLEncoding.default)
        }
    }
}
