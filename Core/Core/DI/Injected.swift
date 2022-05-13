//
//  Injected.swift
//  di
//
//  Created by Phat Le on 29/08/2021.
//

import Swinject

@propertyWrapper public struct Injected<Service>: Resolving {
    private var service: Service?
    private var name: String?

    public init(name: String? = nil) {
        self.service = nil
        self.name = name
    }

    public var wrappedValue: Service {
        mutating get {
            if service == nil {
                if name != nil {
                    service = resolve(Service.self, name: name)
                } else {
                    service = resolve(Service.self)
                }
            }
            return service!
        }
        mutating set {
            service = newValue
        }
    }

    public var projectedValue: Injected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}
