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
    
    public func fetchMovie(id: String) -> AnyPublisher<Movie, MovieError> {
        let target = MovieTarget.fetchMovie(id: id)
        return network.requestPublisher(targetType: target)
            .tryMap { movie -> Movie in
                return movie
            }
            .mapError { error -> MovieError in
                print("🌶🌶🌶 fetchMovie \(id) error: \(error)")
                return .fetchMovie
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchRecommendations(id: String) -> AnyPublisher<MovieListResponse, MovieError> {
        let target = MovieTarget.fetchRecommendations(id: id)
        return network.requestPublisher(targetType: target)
            .tryMap { movieList -> MovieListResponse in
                return movieList
            }
            .mapError { error -> MovieError in
                print("🌶🌶🌶 fetchRecommendations error: \(error)")
                return .fetchRecommendations
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchSimilarMovies(id: String) -> AnyPublisher<MovieListResponse, MovieError> {
        let target = MovieTarget.similar(id: id)
        return network.requestPublisher(targetType: target)
            .tryMap { movieList -> MovieListResponse in
                return movieList
            }
            .mapError { error -> MovieError in
                print("🌶🌶🌶 fetchRecommendations error: \(error)")
                return .similar
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchMovieByCategory(category: MovieCategory) -> AnyPublisher<MovieListResponse, MovieError> {
        let movieTarget: MovieTarget = category.initMovieTarget()
        switch movieTarget {
        case .nowPlaying, .popular, .upcoming, .topRated:
            return network.requestPublisher(targetType: movieTarget)
                .tryMap { movieList -> MovieListResponse in
                    return movieList
                }
                .mapError { error -> MovieError in
                    print("🌶🌶🌶 \(movieTarget)  error: \(error)")
                    return MovieError(rawValue: "\(movieTarget)") ?? .outOfTarget
                }
                .eraseToAnyPublisher()
        default:
            return AnyPublisher(Fail<MovieListResponse, MovieError>(error: .outOfTarget))
        }
    }
    
    public func fetchCredit(id: String) -> AnyPublisher<CreditResponse, MovieError> {
        let target = MovieTarget.fetchCredit(id: id)
        return network.requestPublisher(targetType: target)
            .tryMap { result -> CreditResponse in
                return result
            }
            .mapError { error -> MovieError in
                print("🌶🌶🌶 fetchCredit error: \(error)")
                return .fetchCredits
            }
            .eraseToAnyPublisher()
    }
}

extension MovieCategory {
    func initMovieTarget() -> MovieTarget {
        switch self {
        case .popular:
            return MovieTarget.popular
        case .nowPlaying:
            return MovieTarget.nowPlaying
        case .upcoming:
            return MovieTarget.upcoming
        case .topRated:
            return MovieTarget.topRated
        }
    }
}

public enum MovieTarget {
    case nowPlaying
    case popular
    case upcoming
    case topRated
    case searchMovie(input: String)
    case fetchMovie(id: String)
    case fetchRecommendations(id: String)
    case fetchCredit(id: String)
    case similar(id: String)
}

extension MovieTarget: TargetType {
    public var apiKey: String {
        return TmdbInfo.apiKey
    }

    public var baseURL: URL {
        return URL(string: TmdbInfo.endpointUrl)!
    }
    
    public var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .upcoming:
            return "/movie/upcoming"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .searchMovie:
            return "/search/movie"
        case .fetchMovie(let id):
            return "/movie/\(id)"
        case .fetchRecommendations(let id):
            return "/movie/\(id)/recommendations"
        case .fetchCredit(let id):
            return "/movie/\(id)/credits"
        case .similar(let id):
            return "/movie/\(id)/similar"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .searchMovie, .fetchMovie, .fetchRecommendations, .topRated, .popular, .nowPlaying, .upcoming, .fetchCredit, .similar:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .searchMovie(let input):
            return .requestParameters(parameters: ["query": input, "api_key": apiKey], encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.default)
        }
    }
}
