//
//  AppState.swift
//  FluxCore
//
//  Created by ExecutionLab's Macbook on 03/06/2022.
//

import Foundation
import SwiftUIFlux
import Domain

struct AppState: FluxState, Codable {
    var moviesState: MoviesState
}

struct MoviesState: FluxState, Codable {
    var movies: [Int: Movie] = [:]
    var movieList: [MovieCategory: Movie] = [:]
    
    var search: [String: [Int]] = [:]
    var searchKeywords: [String: [Keyword]] = [:]
    var recentSearches: Set<String> = Set()
    
    enum CodingKeys: String, CodingKey {
        case movies
    }
}


struct Keyword: Codable, Identifiable {
    let id: Int
    let name: String
}


