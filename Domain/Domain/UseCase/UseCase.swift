//
//  UseCase.swift
//  Domain
//
//  Created by Phat Le on 15/04/2022.
//

import Foundation
import Combine

@available(iOS 15.0.0, *)
public protocol AsyncUseCase {
    associatedtype Input
    associatedtype Output

    func callAsFunction(_ input: Input) async throws -> Output
    func onCleared()
}

@available(iOS 15.0.0, *)
public extension AsyncUseCase {
    func onCleared() {}
}

@available(iOS 15.0.0, *)
public extension AsyncUseCase where Input == Void {
    func callAsFunction() async throws -> Output {
        return try await self(())
    }
}

// ======================================

public protocol CombineUseCase {
    associatedtype Input
    associatedtype Output
    associatedtype Failure: Error = Error

    func callAsFunction(_ input: Input) -> AnyPublisher<Output, Failure>
    func onCleared()
}

public extension CombineUseCase {
    func onCleared() {}
}

public extension CombineUseCase where Input == Void {
    func callAsFunction() -> AnyPublisher<Output, Failure> {
        return self(())
    }
}
