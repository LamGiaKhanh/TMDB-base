//
//  KabuPlusService.swift
//  Domain
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation
import Combine

public protocol KabuPlusService {
    func postPushToken(deviceToken: String) -> AnyPublisher<Any, KabuPlusError>
}

public enum KabuPlusError: Error {
    case postPushToken
}
