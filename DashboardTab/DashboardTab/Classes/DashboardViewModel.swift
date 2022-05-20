//
//  DashboardViewModel.swift
//  DashboardTab
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import Foundation
import Combine
import Domain
import Core

public protocol DashboardViewModel: LoadableViewModel, Stepper {
    var popularList: [Movie] { get set }
    var upcomingList: [Movie] { get set }
    var topRatedList: [Movie] { get set }
    var nowPlayingList: [Movie] { get set }
    
    func logout()
    func emptyList()
    func chainingFetch()
}

public class DashboardViewModelImpl: DashboardViewModel, ObservableObject {
    
    public var cancellables = Set<AnyCancellable>()
    public let steps = PassthroughSubject<Step, Never>()
    
    @Injected var logoutUseCase: LogOutUseCase
    @Injected var fetchCategoryUseCase: MovieCategoryUseCase
    
    @Published public var popularList: [Movie] = []
    @Published public var upcomingList: [Movie] = []
    @Published public var topRatedList: [Movie] = []
    @Published public var nowPlayingList: [Movie] = []
    
    @Published public var viewModelState: LoadableState = .idle
    
    public init() { }
    
    public func logout() {
        logoutUseCase().sink(receiveCompletion: { _ in }, receiveValue: { [weak self] _ in
            self?.steps.send(DashboardStep.logout)
        })
        .store(in: &cancellables)
    }
    
    public func fetchCategory(category: MovieCategory) -> AnyCancellable {
        return fetchCategoryUseCase(category).sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
            switch category {
            case .nowPlaying:
                self?.nowPlayingList = result.movies
            case .upcoming:
                self?.upcomingList = result.movies
            case .topRated:
                self?.topRatedList = result.movies
            case .popular:
                self?.popularList = result.movies
            }
        })
    }
    
    public func emptyList() {
        nowPlayingList = []
        upcomingList = []
        topRatedList = []
        popularList = []
    }
    
    public func chainingFetch() {
        viewModelState = .loading
        print("LOADING...")
        Publishers.Zip4(
            fetchCategoryUseCase(.nowPlaying),
            fetchCategoryUseCase(.upcoming),
            fetchCategoryUseCase(.topRated),
            fetchCategoryUseCase(.popular))
            .sink { _ in
            } receiveValue: { [weak self] (nowPlayingResult, upcomingResult, topRatedResult, popularResult) in
                self?.nowPlayingList = nowPlayingResult.movies
                self?.upcomingList = upcomingResult.movies
                self?.topRatedList = topRatedResult.movies
                self?.popularList = popularResult.movies
                self?.viewModelState = .loaded
                print("Loaded...")
            }.store(in: &cancellables)
    }
}
