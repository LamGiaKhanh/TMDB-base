//
//  AnalyticsApplicationService.swift
//  Gokuu
//
//  Created by Tien Nguyen on 9/21/20.
//  Copyright © 2020 Teqnological Asia. All rights reserved.
//

import Foundation

public protocol AnalyticsProvider {
    var identifier: String { get }
    func log(_ event: AnalyticsEventType)
}

public protocol AnalyticsEventType {
    var providers: [Analytics.Provider]? { get }
    var method: Analytics.Method? { get }
    var name: String { get }
    var parameters: [String: Any]? { get }
}

public extension AnalyticsEventType {
    var providers: [Analytics.Provider]? { return Analytics.Provider.allCases }
    var method: Analytics.Method? { return .trackState }
    var parameters: [String: Any]? { return [ AnalyticsKey.pageDetail.rawValue: name ] }
}

public protocol AnalyticsApplicationService {
    func register(provider: AnalyticsProvider)
    func log(_ event: AnalyticsEventType)
}

public final class AnalyticsApplicationManager: NSObject, AnalyticsApplicationService {
    private(set) public var providers: [AnalyticsProvider] = []

    public func register(provider: AnalyticsProvider) {
        self.providers.append(provider)
    }

    public func log(_ event: AnalyticsEventType) {
        for provider in self.providers.filter({ (event.providers?.map { $0.rawValue }.contains($0.identifier) ?? false) }) {
            provider.log(event)
        }

        #if DEBUG
            let jsonData = try? JSONSerialization.data(withJSONObject: event.parameters ?? [:], options: [])
            let param = String(data: jsonData!, encoding: .utf8) ?? ""
            print("🎃🎃🎃 event(\(event.name)), method(\(String(describing: event.method?.rawValue ?? "")), param(\(String(describing: param)), provider(\(String(describing: event.providers?.description ?? "")))")
        #endif
    }
}
