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

public protocol SearchMovieViewModel: ViewModel, Stepper {
    var movieList: [Movie] { get set }
    
    func onUpdateTextDebounced(text: String)
}

public final class SearchMovieViewModelImpl: SearchTextObservable, SearchMovieViewModel {
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
        
    @Injected var searchMovieUseCase: SearchMovieUseCase
    
    @Published public var movieList: [Movie] = []
    
    public override func onUpdateTextDebounced(text: String) {
        searchMovieUseCase(text)
            .sink(receiveCompletion: { error in
                return
            }, receiveValue: { [weak self] movieListResponse in
                print("MOVIES: \(movieListResponse)")
                self?.movieList = movieListResponse.movies
            })
        .store(in: &cancellables)
    }
    
}

