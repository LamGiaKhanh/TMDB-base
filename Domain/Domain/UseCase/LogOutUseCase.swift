//
//  LogOutUseCase.swift
//  Domain
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation
import Combine
import Core

public class LogOutUseCase: CombineUseCase {
    public typealias Input = Void
    public typealias Output = Void
    public typealias Failure = AmazonError

    @Injected var amazonService: AmazonService
    @Injected var tokenService: TokenService

    public init() {}

    public func callAsFunction(_ input: Void) -> AnyPublisher<Void, AmazonError> {
        tokenService.setAccessToken(token: nil)
        return amazonService.signOut()
    }
}
