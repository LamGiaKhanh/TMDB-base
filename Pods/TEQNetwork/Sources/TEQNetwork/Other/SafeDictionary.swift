//
//  SafeDictionary.swift
//  TEQNetwork
//
//  Created by Tien Nguyen on 6/4/19.
//

import Foundation

public final class SafeDictionary<Key: Hashable, Value> {
    var dictionary: [Key: Value] = [:]
    var concurrentQueue: DispatchQueue

    public init(queueLabel: String = "asia.teqnological.safedictionary.concurrent") {
        self.concurrentQueue = DispatchQueue(label: queueLabel, attributes: .concurrent)
    }

    public var keys: Dictionary<Key, Value>.Keys {
        return dictionary.keys
    }

    public subscript(key: Key) -> Value? {
        get {
            getValue(key: key)
        }
        set(newValue) {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }

    public func getValue(key: Key) -> Value? {
        var valueOfKey: Value?
        concurrentQueue.sync {
            valueOfKey = dictionary[key]
        }
        return valueOfKey
    }

    public func updateValue(_ value: Value, forKey: Key) {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.dictionary.updateValue(value, forKey: forKey)
        }
    }

    public func removeValue(forKey key: Key) {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.dictionary.removeValue(forKey: key)
        }
    }

    public func removeAll(keepingCapacity: Bool = false) {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.dictionary.removeAll(keepingCapacity: keepingCapacity)
        }
    }
}
