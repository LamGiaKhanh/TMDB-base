//
//  Analytics.swift
//  Gokuu
//
//  Created by Tien Nguyen on 9/21/20.
//  Copyright © 2020 Teqnological Asia. All rights reserved.
//
import Foundation

// swiftlint:disable type_body_length
public enum Analytics {
    public enum Provider: String, CaseIterable {
        case adobe
        case appsflyer
    }

    public enum Method: String {
        case trackState
        case trackAction
    }

    public enum Key: String {
        case userId = "user_id"
        case userType = "user_type"
        case amcId = "amc_id"
        case pageDetail = "page_detail"
        case actionPage = "action_page"
        case elapsedDays = "elapsed_days"
    }

    public enum Event {
        public enum Onboarding {
            case splash
        }
    }
}

typealias AnalyticsEvent = Analytics.Event
typealias AnalyticsKey = Analytics.Key
