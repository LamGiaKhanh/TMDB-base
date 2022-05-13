//
//  AuthenticaticateUseCase.swift
//  Domain
//
//  Created by Phat Le on 15/04/2022.
//

import Foundation
import Combine
import Core

public class AuthenticateUseCase: CombineUseCase {
    public typealias Input = AuthenParams
    public typealias Output = Bool
    public typealias Failure = AmazonError

    @Injected var amazonService: AmazonService
    @Injected var tokenService: TokenService

    public init() {}

    public func callAsFunction(_ input: AuthenParams) -> AnyPublisher<Bool, AmazonError> {
        return amazonService.signIn(params: input)
            .map { [weak self] session -> Bool in
                self?.saveAmazonToken(sessionData: session)
                return true
            }
            .eraseToAnyPublisher()
    }

    func saveAmazonToken(sessionData: SessionData){
        tokenService.setAccessToken(token: sessionData.accessToken)
        tokenService.setRefreshToken(token: sessionData.refreshToken)
    }
}
