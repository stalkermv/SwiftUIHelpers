//
//  EnvironmentOrValue.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 13.09.2024.
//

import SwiftUI

/// A property wrapper that provides a value from the environment if available, or falls back to a manually-supplied value.
///
/// `EnvironmentOrValue` allows you to write components that use a value from the SwiftUI `Environment`
/// when injected, or fall back to a specified default value otherwise. You can both read and write the value;
/// writing will override the environment-derived value.
///
/// This is useful for making views configurable while still respecting global settings.
///
/// ```swift
/// struct ExampleView: View {
///     @EnvironmentOrValue(\.colorScheme) var colorScheme
///
///     var body: some View {
///         Text("Current scheme: \(colorScheme == .dark ? "Dark" : "Light")")
///     }
/// }
/// ```
///
/// You can also pass an explicit value:
///
/// ```swift
/// ExampleView(colorScheme: .dark)
/// ```
@frozen
@propertyWrapper
public struct EnvironmentOrValue<Value>: DynamicProperty {

    @usableFromInline
    enum Storage: DynamicProperty {
        /// Uses a value from the SwiftUI environment.
        case environment(Environment<Value>)
        /// Uses a manually provided value.
        case value(Value)
    }

    @usableFromInline
    var storage: Storage

    /// Initializes the wrapper with a direct value.
    ///
    /// - Parameter value: A constant value to use in place of one from the environment.
    @inlinable
    public init(_ value: Value) {
        self.storage = .value(value)
    }

    /// Initializes the wrapper with a key path into the SwiftUI `EnvironmentValues`.
    ///
    /// - Parameter keyPath: A key path referencing a specific environment value.
    @inlinable
    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.storage = .environment(.init(keyPath))
    }

    /// The current value, either from the environment or the assigned value.
    ///
    /// Writing to this property overrides the current value, switching it from environment-backed to value-backed.
    public var wrappedValue: Value {
        get {
            switch storage {
            case .environment(let environment):
                return environment.wrappedValue
            case .value(let value):
                return value
            }
        }
        set {
            storage = .value(newValue)
        }
    }

    /// Indicates whether the current value was manually set, rather than derived from the environment.
    public var isValue: Bool {
        switch storage {
        case .environment:
            return false
        case .value:
            return true
        }
    }
}
