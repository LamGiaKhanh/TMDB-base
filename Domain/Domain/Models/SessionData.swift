//
//  SessionData.swift
//  Domain
//
//  Created by Phat Le on 13/04/2022.
//

import Foundation

public struct SessionData: Equatable {
    public let accessToken: String
    public let refreshToken: String

    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
