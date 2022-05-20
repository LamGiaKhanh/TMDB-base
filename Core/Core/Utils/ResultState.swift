//
//  ResultState.swift
//  Core
//
//  Created by ExecutionLab's Macbook on 19/05/2022.
//

import Foundation

enum ResultState: Equatable {
    case loading
    case failed(error: Error)
    case success(content: AnyObject)
    
    static func == (lhs: ResultState, rhs: ResultState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.failed(let lhsType), .failed(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.success(let lhsType), .success(let rhsType)):
            return lhsType === rhsType
        default:
            return false
        }
    }
}
