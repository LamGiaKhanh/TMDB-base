//
//  Environment.swift
//  Alamofire
//
//  Created by Phat Le on 05/04/2022.
//

import Foundation

public protocol Environment {
    var baseApiUrl: String { get }
    var constApiUrl: String { get }
    var awsClientId: String { get }
    var awsUserPoolId: String { get }
    var appleAppID: String { get }
    var appsFlyerDevKey: String { get }
    var adobeAppId: String { get }
}

public enum EnvironmmentMode: String {
    case development = "Development"
    case staging     = "Staging"
    case production  = "Production"
}

public final class ConfigurationEnvironment {
    private let config: NSDictionary

    init(config: NSDictionary) {
        self.config = config
    }

    convenience init(mode: EnvironmmentMode) {
        let bundle = Bundle(for: Self.self)
        let configFile = bundle.path(forResource: "ConfigurationEnvironment", ofType: "plist")!
        let config = NSDictionary(contentsOfFile: configFile)

        let dict = NSMutableDictionary()

        if let commonConfig = config?["Common"] as? [AnyHashable: String] {
            dict.addEntries(from: commonConfig)
        }

        if let environmentConfig = config?[mode.rawValue] as? [AnyHashable: Any] {
            dict.addEntries(from: environmentConfig)
        }

        self.init(config: dict)
    }
}

extension ConfigurationEnvironment: Environment {
    public var baseApiUrl: String {
        return config["BaseApiUrl"] as! String
    }

    public var constApiUrl: String {
        return config["ConstApiUrl"] as! String
    }

    public var awsClientId: String {
        return config["AWSClientId"] as! String
    }

    public var awsUserPoolId: String {
        return config["AWSUserPoolId"] as! String
    }

    public var appleAppID: String {
        return config["AppleAppID"] as! String
    }

    public var appsFlyerDevKey: String {
        return config["AppsFlyerDevKey"] as! String
    }

    public var adobeAppId: String {
        return config["AdobeAppId"] as! String
    }
}
