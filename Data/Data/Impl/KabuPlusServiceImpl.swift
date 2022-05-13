//
//  KabuPlusServiceImpl.swift
//  Data
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation
import Combine
import Domain
import Core
import TEQNetwork
import Alamofire

public class KabuPlusServiceImpl: KabuPlusService {
    @Injected var network: TEQNetwork

    public init() {}

    public func postPushToken(deviceToken: String) -> AnyPublisher<Any, KabuPlusError> {
        return Empty(completeImmediately: true)
            .eraseToAnyPublisher()
    }
}

public enum KabuPlusTarget {
    case postPushToken(String)
}

extension KabuPlusTarget: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "")!
        }
    }

    public var path: String {
        switch self {
        case .postPushToken:
            return ""
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .postPushToken:
            return .post
        }
    }

    public var task: Task {
        switch self {
        case .postPushToken(let token):
            return .requestParameters(parameters: ["": token], encoding: JSONEncoding.default)
        }
    }
}
