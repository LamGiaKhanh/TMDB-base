//
//  ViewModel.swift
//  Common
//
//  Created by Phat Le on 27/04/2022.
//

import Combine
import SwiftUI

public protocol AnyObservableObject: AnyObject {
    var objectWillChange: ObservableObjectPublisher { get }
}

public protocol ViewModel: AnyObservableObject {}

public protocol NavigatorModel: Navigator & ViewModel {}

public protocol LoadableViewModel: ViewModel {
    var viewModelState: LoadableState { get set }
}

public enum LoadableState: Equatable {
    public static func == (lhs: LoadableState, rhs: LoadableState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.idle, .idle):
            return true
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
    
    case idle
    case loading
    case failed(Error)
    case loaded
}
