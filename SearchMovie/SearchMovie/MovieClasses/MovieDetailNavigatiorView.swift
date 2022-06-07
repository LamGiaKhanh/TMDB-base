//
//  MovieDetailNavigatiorView.swift
//  MovieDetail
//
//  Created by ExecutionLab's Macbook on 24/05/2022.
//

import Foundation
import SwiftUI
import Core
import Combine
import Resources

public struct MovieDetailNavigatorView: View {
    @Store public var navigator: MovieDetailNavigator
    
    public init(navigator: MovieDetailNavigator) {
        _navigator = Store(wrappedValue: navigator)
    }
    
    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            NavigationView {
                MovieDetailView(viewModel: navigator.movieDetailViewModel, isRootView: navigator.isRootView)
                    .hideNavigationBar()
                    .sheet(model: $navigator.duplicateMovieDetailNavigator) {
                        MovieDetailNavigatorView(navigator: $0)
                            .hideNavigationBar()
                            .handleIsPresented($1, onActive: save(_:), onInactive: remove)
                    }
                    .sheet(model: $navigator.testViewModel) {
                        PresentTestView(viewModel: $0)
                            .handleIsPresented($1, onActive: save(_:), onInactive: remove)
                            .sheet(model: $navigator.testViewModel1) {
                                PresentTestView(viewModel: $0, next: MovieDetailStep.testView2)
                                    .handleIsPresented($1, onActive: save(_:), onInactive: remove)
                                    .sheet(model: $navigator.testViewModel2) {
                                        PresentTestView(viewModel: $0)
                                            .handleIsPresented($1, onActive: save(_:), onInactive: remove)
                                    }
                            }
                    }
            }
        }
        .navigationViewStyle(.stack)
    }
}

private extension MovieDetailNavigatorView {
    func save(_ isPresented: Binding<Bool>) {
        navigator.presentedList.append(isPresented)
    }

    func remove() {
        navigator.presentedList.removeLast()
    }
}

public protocol TestViewModel: ViewModel, Core.Stepper {
    func makeDetailModel() -> TestViewModel
}

class TestViewModelImpl: TestViewModel, ObservableObject, Resolving {
    var cancellables = Set<AnyCancellable>()

    var steps = PassthroughSubject<Step, Never>()

    deinit {
        print("TestViewModelImpl deinit")
    }

    func makeDetailModel() -> TestViewModel {
        let v = resolve(TestViewModel.self)
        return v
    }
}

struct PresentTestView: View {
    @Store var viewModel: TestViewModel
    var next: Step = MovieDetailStep.testView1
    @SwiftUI.Environment(\.presentationMode) var pre

    var body: some View {
        VStack {
            Text("PresentTestView")
            Button("other") {
                viewModel.steps.send(next)
            }
            Button("single dismiss") {
                pre.wrappedValue.dismiss()
            }
            Button("dismiss") {
                viewModel.steps.send(MovieDetailStep.dismiss)
            }
        }
    }
}
