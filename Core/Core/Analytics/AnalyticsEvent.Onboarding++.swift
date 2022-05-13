//
//  AnalyticsEvent.Onboarding+Ext.swift
//  Gokuu
//
//  Created by Tien Nguyen on 9/24/20.
//  Copyright © 2020 Teqnological Asia. All rights reserved.
//
import Foundation

extension AnalyticsEvent.Onboarding: AnalyticsEventType {
    public var name: String {
        switch self {
        case .splash:
            return "splash"
        }
    }
}
