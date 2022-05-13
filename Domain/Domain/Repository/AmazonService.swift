//
//  AmazonService.swift
//  Domain
//
//  Created by Phat Le on 13/04/2022.
//

import Combine

public protocol AmazonService {
    func configAmplify(awsUserPoolId: String,
                       awsClientId: String,
                       flowType: AWSAuthenFlowType)
    func signIn(params: AuthenParams) -> AnyPublisher<SessionData, AmazonError>
    func refreshToken() -> AnyPublisher<SessionData, AmazonError>
    func signOut() -> AnyPublisher<Void, AmazonError>
}

public enum AmazonError: Error {
    case signIn
    case confirmSignIn
    case refreshToken
    case signOut
}

public struct AuthenParams: Equatable {
    public let username: String
    public let password: String
    public let clientMetaData: [String: String]?

    public init(username: String, password: String, clientMetaData: [String : String]? = nil) {
        self.username = username
        self.password = password
        self.clientMetaData = clientMetaData
    }
}
