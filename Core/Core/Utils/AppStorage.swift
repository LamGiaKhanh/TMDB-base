//
//  AppStorage.swift
//  Common
//
//  Created by Phat Le on 18/04/2022.
//

import Foundation

@propertyWrapper
public struct AppStorage<Value> {
    let key: String
    var defaultValue: Value?
    var storage: UserDefaults = .standard

    public init(key: String, defaultValue: Value? = nil, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    public var wrappedValue: Value? {
        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }
}

@propertyWrapper
public struct AppStorageObject<T: Codable> {
    private let key: String
    var storage: UserDefaults = .standard

    public init(key: String, storage: UserDefaults = .standard) {
        self.key = key
        self.storage = storage
    }

    public var wrappedValue: T? {
        get {
            guard let data = storage.object(forKey: key) as? Data,
                  let value = try? JSONDecoder().decode(T.self, from: data) else { return nil }
            return value
        }
        set {
            guard let newValue = newValue else {
                storage.set(nil, forKey: key)
                return
            }
            do {
                let data = try JSONEncoder().encode(newValue)
                storage.set(data, forKey: key)
            } catch let error {
                print("[AppStorageObject] error: \(error) ")
            }
        }
    }
}
