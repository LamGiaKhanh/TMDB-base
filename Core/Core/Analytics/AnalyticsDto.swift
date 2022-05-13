//
//  AnalyticsDto.swift
//  Gokuu
//
//  Created by Tien Nguyen on 9/23/20.
//  Copyright © 2020 Teqnological Asia. All rights reserved.
//

import Foundation

struct AnalyticsDto: AnalyticsEventType {
    var providers: [Analytics.Provider]? = Analytics.Provider.allCases
    var method: Analytics.Method? = .trackState
    var name: String
    var parameters: [String: Any]?

    var contextData: [String: Any] {
        return [:]
    }

    init(event: AnalyticsEventType, hasContextData: Bool = true) {
        self.providers = event.providers
        self.method = event.method
        self.name = event.name

        var params = event.parameters
        if hasContextData {
            params?.append(contextData)
        }
        self.parameters = params
    }
}
