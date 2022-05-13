//
//  TokenService.swift
//  Domain
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation

public protocol TokenService {
    func setAccessToken(token: String?)
    func setPushToken(token: String)
    func setRefreshToken(token: String)
    func getAccessToken() -> String?
    func getPushToken() -> String
    func getRefreshToken() -> String
    func isAccessTokenValid() -> Bool
}
