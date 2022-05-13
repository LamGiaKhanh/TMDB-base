//
//  NetworkRequestRetrier.swift
//  Data
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation
import Combine
import TEQNetwork
import Domain
import Core

class NetworkRequestRetrier: RequestRetrier {
    @Injected var refreshToken: RefreshTokenUseCase

    var store = Set<AnyCancellable>()

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            return completion(.doNotRetryWithError(error))
        }

        switch response.statusCode {
        case 401:
            return retryWithRefreshToken(error: error, completion: completion)
        case 503:
            return completion(.doNotRetryWithError(error))
        default:
            return completion(.doNotRetryWithError(error))
        }
    }

    func retryWithRefreshToken(error: Error, completion: @escaping (RetryResult) -> Void) {
        refreshToken()
            .sink { result in
                switch result {
                case .failure(_):
                    completion(.doNotRetryWithError(error))
                case .finished:
                    print("")
                }
            } receiveValue: { _ in
                completion(.retry)
            }
            .store(in: &store)
    }
}
