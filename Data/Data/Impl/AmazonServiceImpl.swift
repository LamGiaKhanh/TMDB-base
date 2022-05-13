//
//  AmazonServiceImpl.swift
//  Data
//
//  Created by Phat Le on 14/04/2022.
//

import Combine
import Domain
import Amplify
import AmplifyPlugins
import AWSPluginsCore

public class AmazonServiceImpl: AmazonService {
    public init() {}

    public func configAmplify(awsUserPoolId: String,
                              awsClientId: String,
                              flowType: AWSAuthenFlowType) {
        do {
            let authConfig = AuthCategoryConfiguration(plugins: [
                "awsCognitoAuthPlugin": [
                    "IdentityManager": [
                        "Default": [:]
                    ],
                    "CognitoUserPool": [
                        "Default": [
                            "PoolId": .string(awsUserPoolId),
                            "AppClientId": .string(awsClientId),
                            "Region": "ap-northeast-1"
                        ]
                    ],
                    "Auth": [
                        "Default": [
                            "authenticationFlowType": .string(flowType.rawValue)
                        ]
                    ]
                ]
            ])

            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure(.init(auth: authConfig))
            print("Amplify configured with auth plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }

    public func signIn(params: AuthenParams) -> AnyPublisher<SessionData, AmazonError> {
        let options = AWSAuthSignInOptions(metadata: params.clientMetaData)
        return Amplify.Auth.signIn(username: params.username,
                                   password: params.password,
                                   options: .init(pluginOptions: options))
            .resultPublisher
            .mapError { error -> AmazonError in
                print("🌶🌶🌶 signIn error: \(error)")
                return .signIn
            }
            .flatMap { result -> AnyPublisher<SessionData, AmazonError> in
                switch result.nextStep {
                case .done:
                    return self.refreshToken()
                case .confirmSignInWithCustomChallenge(_):
                    return self.confirmSignIn(challengeResponse: "", metaData: params.clientMetaData)
                default:
                    return Fail<SessionData, AmazonError>(error: .signIn)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    private func confirmSignIn(challengeResponse: String, metaData: [String: String]?) -> AnyPublisher<SessionData, AmazonError> {
        let options = AWSAuthConfirmSignInOptions(metadata: metaData)
        return Amplify.Auth.confirmSignIn(challengeResponse: challengeResponse,
                                          options: .init(pluginOptions: options))
            .resultPublisher
            .mapError { error -> AmazonError in
                print("🌶🌶🌶 confirmSignIn error: \(error)")
                return .confirmSignIn
            }
            .flatMap { signInResult -> AnyPublisher<SessionData, AmazonError> in
                if signInResult.isSignedIn {
                    return self.refreshToken()
                }
                switch signInResult.nextStep {
                case .confirmSignInWithCustomChallenge(_):
                    return self.confirmSignIn(challengeResponse: challengeResponse, metaData: metaData)
                default:
                    break
                }
                return Fail<SessionData, AmazonError>(error: .confirmSignIn)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    public func refreshToken() -> AnyPublisher<SessionData, AmazonError> {
        return Amplify.Auth.fetchAuthSession()
            .resultPublisher
            .tryMap { session -> SessionData in
                if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                    let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                    print("Id token - \(tokens.idToken) ")

                    let sessionData = SessionData(accessToken: tokens.accessToken,
                                                  refreshToken: tokens.refreshToken)
                    return sessionData
                }
                throw AmazonError.refreshToken
            }
            .mapError { error -> AmazonError in
                print("🌶🌶🌶 refreshToken error: \(error)")
                return .refreshToken
            }
            .eraseToAnyPublisher()
    }

    public func signOut() -> AnyPublisher<Void, AmazonError> {
        return Amplify.Auth.signOut().resultPublisher
            .mapError { error -> AmazonError in
                print("🌶🌶🌶 signOut error: \(error)")
                return .signOut
            }
            .eraseToAnyPublisher()
    }
}
