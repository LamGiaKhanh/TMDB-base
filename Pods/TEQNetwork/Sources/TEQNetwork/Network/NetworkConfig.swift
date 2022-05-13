//
//  NetworkConfig.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/14/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation
import Alamofire

public struct NetworkConfig {
    public var decoder: JSONDecoder
    public var errorReporter: ErrorReportable?
    public var adapters: [RequestAdapter]?
    public var retriers: [RequestRetrier]?
    public var monitors: [EventMonitor]?
    public var sessionConfiguration: URLSessionConfiguration

    public init(decoder: JSONDecoder = JSONDecoder(),
                sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.af.default,
                errorReporter: ErrorReportable? = nil,
                adapters: [RequestAdapter]? = nil,
                retriers: [RequestRetrier]? = nil,
                monitors: [EventMonitor]? = nil) {
        self.decoder = decoder
        self.sessionConfiguration = sessionConfiguration
        self.errorReporter = errorReporter
        self.adapters = adapters
        self.retriers = retriers
        self.monitors = monitors
    }

    var interceptor: Interceptor? {
        guard adapters != nil || retriers != nil else { return nil }
        let defaultRetriers: [RequestRetrier] = [ConnectionLostRetryPolicy()]
        return Interceptor(adapters: adapters ?? [], retriers: (retriers ?? []) + defaultRetriers)
    }

    var eventMonitors: [EventMonitor] {
        guard monitors != nil else { return [] }
        return monitors!
    }
}
