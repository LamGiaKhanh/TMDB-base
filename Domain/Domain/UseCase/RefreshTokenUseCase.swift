//
//  RefreshTokenUseCase.swift
//  Domain
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation
import Combine
import Core

public class RefreshTokenUseCase: CombineUseCase {
    public typealias Input = Void
    public typealias Output = SessionData
    public typealias Failure = AmazonError

    @Injected var amazonService: AmazonService

    public init() {}

    public func callAsFunction(_ input: Void) -> AnyPublisher<SessionData, AmazonError> {
        return amazonService.refreshToken()
    }
}
