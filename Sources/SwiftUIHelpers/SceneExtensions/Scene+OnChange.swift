//
//  Scene+OnChange.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 13.12.2024.
//

#if canImport(SwiftHelpers)

import SwiftHelpers
import SwiftUI

extension Scene {
    public func onChange<V>(of value: V, initial: Bool = false, _ action: @escaping (_ oldValue: V, _ newValue: V) -> Void) -> some Scene
    where V : Equatable {
        modifier(_ValueActionModifier(value: value, initial: initial, action: action))
    }
}

struct _ValueActionModifier<Value> : _SceneModifier where Value : Equatable {
    let property: ValueActionProperty<Value>
    
    init(value: Value, initial: Bool, action: @escaping (Value, Value) -> Void) {
        self.property = ValueActionProperty(value: value, initial: initial, action: action)
    }
    
    func body(content: SceneContent) -> some Scene {
        content
            .onChange(of: "") { _ in } // Keep it to trigger the action
    }
}

struct ValueActionProperty<Value: Equatable>: DynamicProperty {
    
    @StoredValue private var value: Value!
    
    private var initialValue: Value
    private var action: (Value, Value) -> Void
    private var useInitial: Bool
    
    init(value: Value, initial: Bool, action: @escaping (Value, Value) -> Void) {
        self.initialValue = value
        
        self.action = action
        self.useInitial = initial
    }
    
    var wrappedValue: Value {
        get { value ?? initialValue }
        set { value = newValue }
    }
    
    func update() {
        guard value != initialValue else { return }
        if useInitial {
            action(initialValue, initialValue)
        } else if let value = value {
            action(initialValue, value)
        }
        
        value = initialValue
    }
}

#endif
