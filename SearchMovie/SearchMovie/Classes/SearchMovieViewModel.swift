//
//  SearchMovieViewModel.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Core
import Combine
import Domain

public protocol SearchMovieViewModel: ViewModel, Stepper {
    func searchMovie(input: String)
}

public class SearchMovieViewModelImpl: SearchMovieViewModel, ObservableObject {
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
        
    @Injected var searchMovieUseCase: SearchMovieUseCase
    
    public init() { }
    
    public func searchMovie(input: String)  {
        searchMovieUseCase.callAsFunction(input)
            .sink(receiveCompletion: { error in
                return
            }, receiveValue: { movieListResponse in
                print("MOVIES: \(movieListResponse)")
                return
            })
        .store(in: &cancellables)
    }
}
