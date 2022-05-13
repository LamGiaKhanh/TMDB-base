//
//  EnvironmentProvider.swift
//  Configuration
//
//  Created by Phat Le on 05/04/2022.
//

public protocol EnvironmentProvider: Resolving {
    var env: Environment { get }
}

extension EnvironmentProvider {
    public var env: Environment { resolve(Environment.self) }
}
