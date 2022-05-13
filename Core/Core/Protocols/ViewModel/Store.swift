//
//  Store.swift
//  Common
//
//  Created by Phat Le on 27/04/2022.
//

import SwiftUI
import Combine

@propertyWrapper
public struct Store<Model>: DynamicProperty {

    @dynamicMemberLookup
    public struct Wrapper {
        fileprivate var store: Store

        public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Model, Value>) -> Binding<Value> {
            Binding(
                get: { self.store.wrappedValue[keyPath: keyPath] },
                set: { self.store.wrappedValue[keyPath: keyPath] = $0 }
            )
        }
    }

    public let wrappedValue: Model

    @ObservedObject
    private var observableObject: ErasedObservableObject

    public var projectedValue: Wrapper {
        Wrapper(store: self)
    }

    public init(wrappedValue: Model) {
        self.wrappedValue = wrappedValue

        if let objectWillChange = (wrappedValue as? AnyObservableObject)?.objectWillChange {
            self.observableObject = .init(objectWillChange: objectWillChange.eraseToAnyPublisher())
        } else {
            self.observableObject = .empty()
        }
    }

    public mutating func update() {
        _observableObject.update()
    }

    class ErasedObservableObject: ObservableObject {

        let objectWillChange: AnyPublisher<Void, Never>

        init(objectWillChange: AnyPublisher<Void, Never>) {
            self.objectWillChange = objectWillChange
        }

        static func empty() -> ErasedObservableObject {
            .init(objectWillChange: Empty().eraseToAnyPublisher())
        }
    }
}
