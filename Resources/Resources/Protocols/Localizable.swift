//
//  Localizable.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import Foundation

// https://medium.com/@mendibarouk/enhance-your-localized-capabilities-on-your-ios-applications-d3ba17138077
public protocol Localizable {
    // Properties for NSLocalizedString function
    var key      : String  { get }
    var tableName: String? { get }
    var bundle   : Bundle  { get }
    var value    : String  { get }
    var comment  : String  { get }
}

// MARK: - Default values of the Localizable protocol properties for the NSLocalizedString function
public extension Localizable {
    var tableName: String? {
        return nil
    }
    var bundle: Bundle {
        return Bundle.main
    }
    var value: String {
        return String()
    }
    var comment: String {
        return String()
    }
}

// MARK: - Localized string property Extraction
public extension Localizable {
    /// Default localized string, helper property
    func callAsFunction() -> String {
        return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }

    /// Public localized string property extracted
    func callAsFunction(arguments: CVarArg...) -> String {
        return String(format: self(), arguments: arguments)
    }
}

// MARK: - Default values where RawRepresentable protocol is implemented and RawRepresentable.RawValue == String
public extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    /// Default key value
    var key: String {
        return rawValue
    }
}
