//
//  Resolving.swift
//  di
//
//  Created by Phat Le on 29/08/2021.
//

import Swinject

public protocol Resolving {
    var resolver: Resolver { get }
    func resolve<Service>(_ serviceType: Service.Type) -> Service
    func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service
    func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, argument1: Arg1, argument2: Arg2) -> Service
    func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service
}

public extension Resolving {
    var resolver: Resolver {
        return RootAssembler.standard.resolver
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return resolver.resolve(serviceType)!
    }

    func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        return resolver.resolve(serviceType, argument: argument)!
    }

    func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, argument1: Arg1, argument2: Arg2) -> Service {
        return resolver.resolve(serviceType, arguments: argument1, argument2)!
    }

    func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service {
        return resolver.resolve(serviceType, name: name)!
    }
}
