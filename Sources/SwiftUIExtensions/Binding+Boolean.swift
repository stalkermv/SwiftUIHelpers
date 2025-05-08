//
//  Binding+Boolean.swift
//
//  Created by Valeriy Malishevskyi on 21.08.2023.
//

#if canImport(FoundationExtensions)

import SwiftUI
import FoundationExtensions

public extension Binding where Value : OptionalProtocol {
    /// A boolean binding representation of the current binding.
    ///
    /// This computed property provides a boolean binding that's `true` when the wrapped value is not `nil` and `false` otherwise. It's useful when you want to create conditions or UI elements based on the presence or absence of a value.
    ///
    /// When setting the binding to `false`, it will set the original binding to `nil`. Setting it to `true` will not modify the original binding.
    ///
    /// Example:
    /// ```swift
    /// @State var text: String? = "Hello"
    ///
    /// var body: some View {
    ///     ToggleClearView("Is not clean?", contentPresented: $text.boolean)
    /// }
    /// ```
    ///
    /// - Note: Setting the boolean binding to `true` will not modify the original binding. You should handle such cases separately.
    @MainActor var boolean: Binding<Bool> {
        Binding<Bool> {
            !wrappedValue.isNone
        } set: { newValue in
            if newValue == false { self.wrappedValue = nil }
        }
    }
}

#endif
