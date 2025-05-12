//
//  Binding+Equals.swift
//
//  Created by Valeriy Malishevskyi on 21.08.2023.
//

import SwiftUI
import FoundationExtensions

public extension Binding {
    /// Initializes a new boolean binding based on the equality of a hashable value.
    ///
    /// - Note: When setting the binding to `false`, it will set the original binding to `nil`
    /// if the current value matches the specified value; otherwise, it will do nothing.
    ///
    /// This initializer allows you to create a boolean binding that's `true` when the provided hashable value matches
    /// the specified value and `false` otherwise.
    /// It's especially useful when working with enums or other hashable types
    /// where you want to create conditions based on the current value.
    ///
    /// Example:
    /// ```swift
    /// enum SelectedArea {
    ///     case top
    ///     case bottom
    /// }
    /// @State var selected: SelectedArea? = SelectedArea.top
    ///
    /// var body: some View {
    ///     Text("Hello, World!")
    ///         .sheet(isPresented: Binding($selected, equals: .bottom), content: {
    ///             Text("Sheet Content")
    ///         })
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - binding: A binding to a hashable value.
    ///   - value: The value to compare against the hashable value.
    init<ScopeValue: Sendable>(_ binding: Binding<ScopeValue>, equals value: ScopeValue)
    where ScopeValue : Hashable, ScopeValue : OptionalProtocol, Value == Bool {
        self.init {
            return binding.wrappedValue == value
        } set: { newValue in
            if binding.wrappedValue == value, !newValue {
                binding.wrappedValue = nil
            } else if newValue {
                binding.wrappedValue = value
            }
        }
    }
}
