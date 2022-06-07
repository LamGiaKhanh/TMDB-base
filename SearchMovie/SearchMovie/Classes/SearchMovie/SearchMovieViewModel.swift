//
//  SearchMovieViewModel.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Core
import Combine
import Domain
import Resources
import Common

public protocol SearchMovieViewModel: LoadableViewModel, Stepper {
    var movieList: [Movie] { get set }
    var query: String { get set }
    
    func onUpdateTextDebounced(text: String)
}

public final class SearchMovieViewModelImpl: SearchTextObservable, SearchMovieViewModel {
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
        
    @Injected var searchMovieUseCase: SearchMovieUseCase
    
    @Published public var movieList: [Movie] = []
    @Published public var query = ""
    @Published public var viewModelState: LoadableState = .idle

    public override func onUpdateTextDebounced(text: String) {
        guard !text.isEmpty else {
            viewModelState = .idle
            return
        }
        viewModelState = .loading
        query = text
        searchMovieUseCase(text)
            .sink(receiveCompletion: { error in
                return
            }, receiveValue: { [weak self] movieListResponse in
                print("MOVIES: \(movieListResponse)")
                self?.movieList = movieListResponse.movies
                self?.viewModelState = .loaded
            })
        .store(in: &cancellables)
    }
    
}

