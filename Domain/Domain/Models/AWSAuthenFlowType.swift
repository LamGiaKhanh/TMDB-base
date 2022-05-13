//
//  AWSAuthenFlowType.swift
//  Data
//
//  Created by Phat Le on 15/04/2022.
//

import Foundation

public enum AWSAuthenFlowType: String {
    case userSrpAuth = "USER_SRP_AUTH"
    case refreshTokenAuth = "REFRESH_TOKEN_AUTH"
    case refreshToken = "REFRESH_TOKEN"
    case customAuth = "CUSTOM_AUTH"
    case adminNoSrpAuth = "ADMIN_NO_SRP_AUTH"
    case userPasswordAuth = "USER_PASSWORD_AUTH"
    case adminUserPasswordAuth = "ADMIN_USER_PASSWORD_AUTH"
    case unknown
}
