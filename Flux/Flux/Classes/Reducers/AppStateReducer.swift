//
//  AppStateReducer.swift
//  FluxCore
//
//  Created by ExecutionLab's Macbook on 03/06/2022.
//

import Foundation
import SwiftUIFlux
import Domain

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    state.searchMovieState = searchMovieStateReducer(state: state, action: action)
}

func searchMovieStateReducer(state: MoviesState, action: Action) -> MoviesState {
    var state = state
    
    switch action {
    case let action as MoviesActions.SetMovieList:
        if var list = state.movies[action.category] {
            list.append(contentsOf: action.response.movies.map { $0.id})
            state.movies[action.category] = list
        } else {
            state.movies[action.category] = action.response.movies.map { $0.id }
        }
    default:
        break
    }
}

func +=(lhs: inout [Int: Movie], rhs: [Movie]) {
    for movie in rhs {
        lhs[movie.id] = movie
    }
}

private func mergeMovies(movies: [Movie], state: MoviesState) -> MoviesState {
    var state = state
    for movie in movies {
        if state.movies[movie.id] == nil {
            state.movies[movie.id] = movie
        }
    }
    return state
}
