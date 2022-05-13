//
//  DataAssembly.swift
//  Alamofire
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation
import Core
import Domain
import TEQNetwork

public class DataAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(TEQNetwork.self) { r in
            let tokenService = r.resolve(TokenService.self)
            var adapters: [RequestAdapter] = []
            adapters.append(AuthenticationAdapter {
                if let accessToken = tokenService?.getAccessToken() {
                    return AuthenticationAdapter.Authentication.bearer(token: accessToken)
                } else {
                    return nil
                }
            })
            let sessionConfig = URLSessionConfiguration.af.default
            sessionConfig.timeoutIntervalForRequest = 60
            return TEQNetwork(config: NetworkConfig(sessionConfiguration: sessionConfig,
//                                                    errorReporter: CrashReporter.shared,
                                                    adapters: adapters,
                                                    retriers: [NetworkRequestRetrier()],
                                                    monitors: [NetworkLogger(level: .info)]))
        }

        container.register(AmazonService.self) { _ in
            AmazonServiceImpl()
        }

        container.register(KabuPlusService.self) { _ in
            KabuPlusServiceImpl()
        }

        container.register(TokenService.self) { _ in
            TokenServiceImpl()
        }.inObjectScope(.container)
    }
}
