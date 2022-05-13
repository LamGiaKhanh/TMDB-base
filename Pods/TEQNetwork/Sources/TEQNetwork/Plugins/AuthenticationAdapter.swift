//
//  Authentication.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/13/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation

public typealias AuthenticationClosure = () -> AuthenticationAdapter.Authentication?

public final class AuthenticationAdapter: RequestAdapter {
    public enum Authentication {
        case bearer(token: String)
        case basic(token: String)
        case credential(username: String, password: String)
        case custom(name: String, token: String)
    }

    let getAuthenticationClosure: AuthenticationClosure

    public init(_ closure: @escaping AuthenticationClosure) {
        self.getAuthenticationClosure = closure
    }

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let auth = getAuthenticationClosure() {
            switch auth {
            case .basic(let token):
                urlRequest.headers.add(.authorization(token))
            case .bearer(let token):
                urlRequest.headers.add(.authorization(bearerToken: token))
            case .credential(let username, let password):
                urlRequest.headers.add(.authorization(username: username, password: password))
            case .custom(let name, let token):
                urlRequest.headers.add(name: name, value: token)
            }
            completion(.success(urlRequest))
        } else {
            completion(.success(urlRequest))
        }
    }
}
