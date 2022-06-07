//
//  DashboardView.swift
//  DashboardTab
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core
import Resources
import Common
import SkeletonUI

struct DashboardView: View {
    @Store public var viewModel: DashboardViewModel
    
    public init(viewModel: DashboardViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                DashboardHeaderView(viewModel: viewModel)
                
                AppText(.title, "Now Playing")

                MoviesHorizontalListView(movies: viewModel.nowPlayingList) { movie in
                    viewModel.steps.send(DashboardStep.movieDetail(movie))
                }

                    
                AppText(.title, "Popular")

                MoviesHorizontalListView(movies: viewModel.popularList) { movie in
                    viewModel.steps.send(DashboardStep.movieDetail(movie))
                }
                
                
                AppText(.title, "Top Rated")

                MoviesHorizontalListView(movies: viewModel.topRatedList) { movie in
                    viewModel.steps.send(DashboardStep.movieDetail(movie))
                }
                

                AppText(.title, "Upcoming")

                MoviesHorizontalListView(movies: viewModel.upcomingList) { movie in
                    viewModel.steps.send(DashboardStep.movieDetail(movie))
                }
            }
        }.onAppear {
            viewModel.chainingFetch()
        }
    }
}

struct DashboardHeaderView: View {
    @Store public var viewModel: DashboardViewModel
    
    public init(viewModel: DashboardViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    var body: some View {
            AppText(.appTitle, "TMDB")
                .frame(maxWidth: .infinity)
                .overlay(
                    FilledButton(buttonType: .small, "Logout") {
                        viewModel.emptyList()
                        viewModel.chainingFetch()
                    }
                    .padding(),
                    alignment: .trailing
                ).background(ColorfulView()
                                .padding(.bottom, 20))
        
    }
}

struct TestViewWithoutViewModel: View {
    var body: some View {
        VStack {
            Text("TestView without Viewmodel")
        }
    }
}

public protocol TestViewModel: ViewModel {
    
}

class TestViewModelImpl: TestViewModel, ObservableObject {
    
}

struct TestViewWithViewModel: View {
    @Store var viewModel: TestViewModel
    
    var body: some View {
        VStack {
            Text("TestView with ViewModel")
        }
    }
}
