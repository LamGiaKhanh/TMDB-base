//
//  TokenServiceImpl.swift
//  Data
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation
import Domain
import Core

public class TokenServiceImpl: TokenService {
    @AppStorage(key: "accessToken") var accessToken: String?
    @AppStorage(key: "refreshToken", defaultValue: "") var refreshToken: String!
    @AppStorage(key: "pushToken", defaultValue: "") var pushToken: String!

    public init() {}

    public func setAccessToken(token: String?) {
        self.accessToken = token
    }

    public func setPushToken(token: String) {
        self.pushToken = token
    }

    public func setRefreshToken(token: String) {
        self.refreshToken = token
    }

    public func getAccessToken() -> String? {
        return accessToken
    }

    public func getPushToken() -> String {
        return pushToken
    }

    public func getRefreshToken() -> String {
        return refreshToken
    }

    public func isAccessTokenValid() -> Bool {
        return getAccessToken() != nil
    }
}
