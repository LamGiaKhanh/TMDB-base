//
//  MoviesActions.swift
//  FluxCore
//
//  Created by ExecutionLab's Macbook on 03/06/2022.
//

import SwiftUIFlux
import Domain
import Core

typealias MovieList = [Movie]

struct MoviesActions {
    struct FetchMovieList: AsyncAction {
        @Injected var movieCategoryUsecase: MovieCategoryUseCase
        
        let page: Int
        let category: MovieCategory
        
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            movieCategoryUsecase(category)
                .sink { _ in
                } receiveValue: { response in
                    dispatch(SetMovieList(page: self.page, category: self.category, response: response))
                }

        }
    }
    
    struct SetMovieList {
        let page: Int
        let category: MovieCategory
        let response: MovieListResponse
    }
}
