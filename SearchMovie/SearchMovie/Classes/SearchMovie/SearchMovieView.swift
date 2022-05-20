//
//  SearchView.swift
//  SearchMovie
//
//  Created by ExecutionLab's Macbook on 13/05/2022.
//

import SwiftUI
import Core
import Combine
import Common
import Resources
import SkeletonUI

public struct SearchMovieView: View {
    @Store public var viewModel: SearchMovieViewModel
    
    @State private var isSearching = false
    
    public init(viewModel: SearchMovieViewModel) {
        _viewModel = Store(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 6) {
            SearchField(
                searchTextWrapper: viewModel as! SearchTextObservable,
                placeholder: "Search any movies",
                isSearching: $isSearching,
                dismissButtonCallback: {
                    viewModel.viewModelState = .idle
                    viewModel.movieList = []
                }
            ).onPreferenceChange(OffsetTopPreferenceKey.self) { value in
                print("onPreferenceChange \(value)")
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }.frame(maxWidth: .infinity, alignment: .top)
            switch viewModel.viewModelState {
            case .idle:
                Text("Type any to search")
                    .font(R.font.fjallaOneRegular.font(size: 24))
                    .bold()
                    .foregroundColor(R.color.steam_background.color)
                    .background(Color.clear)
                    .frame(maxHeight: .infinity, alignment: .center)
            case .loading, .loaded:
                if viewModel.viewModelState == .loaded  && viewModel.movieList.isEmpty {
                    Text("No Results")
                        .font(R.font.fjallaOneRegular.font(size: 24))
                        .bold()
                        .foregroundColor(R.color.steam_background.color)
                        .background(Color.clear)
                        .frame(maxHeight: .infinity, alignment: .center)
                } else {
                    ZStack {
                        Color.black
                        List {
                            Section(header: HStack {
                                Text("Result for \(viewModel.query)")
                                    .foregroundColor(Color.white)
                                    .font(R.font.fjallaOneRegular.font(size: 13))
                                    .padding()
                                Spacer()
                            }
                            .background(Color.black)
                            .listRowInsets(.init())
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)){
                                SkeletonForEach(with: viewModel.movieList, quantity: 6) { loading , movie in
                                    MovieRow(movie: movie, loading: viewModel.viewModelState == .loading)
                                        .onTapGesture {
                                            if let movie = movie {
                                                viewModel.steps.send(SearchMovieStep.movieDetail(movie))
                                                print("Tap movie \(movie.title)")
                                            }
                                        }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .transition(.move(edge: .leading))
                                .listRowBackground(Color.clear)
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .animation(.spring())
                        .resignKeyboardOnDragGesture()
                    }
                }
                
            default:
                EmptyView()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
