//
//  Created by Valeriy Malishevskyi on 08.11.2023.
//

import SwiftUI

/// A property wrapper that can read and write a value from a wrapped `State` or `Binding`.
@propertyWrapper
@frozen
public enum StateOrBinding<Value>: DynamicProperty {
    
    case state(State<Value>)
    case binding(Binding<Value>)
    
    public var wrappedValue: Value {
        get {
            switch self {
                case .state(let state):
                    return state.wrappedValue
                case .binding(let binding):
                    return binding.wrappedValue
            }
        }
        nonmutating set {
            switch self {
                case .state(let state):
                    state.wrappedValue = newValue
                case .binding(let binding):
                    binding.wrappedValue = newValue
            }
        }
    }
    
    public var projectedValue: Binding<Value> {
        switch self {
            case .state(let state):
                return state.projectedValue
            case .binding(let binding):
                return binding
        }
    }

    @inlinable
    public init(_ value: Value) {
        self = .state(State(initialValue: value))
    }
    
    @inlinable
    public init(_ binding: Binding<Value>) {
        self = .binding(binding)
    }
}
