//
//  Binding+Boolean.swift
//
//  Created by Valeriy Malishevskyi on 21.08.2023.
//

import SwiftUI

public extension Binding {
    /// Returns a boolean binding derived from this optional binding.
    ///
    /// The returned binding is `true` when `wrappedValue` is non-`nil` and `false` otherwise.
    ///
    /// - Setting to `false` writes `nil` to the original binding.
    /// - Setting to `true` is a no-op; the original binding is left unchanged.
    ///
    /// Example:
    /// ```swift
    /// @State var text: String? = "Hello"
    ///
    /// var body: some View {
    ///     ToggleClearView("Is not clean?", isOn: $text.boolean())
    /// }
    /// ```
    ///
    /// - Note: Setting to `true` does not modify the original binding.
    ///   Handle that case at the call site if needed.
    func boolean<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        self[dynamicMember: \.hasValue]
    }
}

private extension Optional {
    var hasValue: Bool {
        get { self != nil }
        set { if !newValue { self = nil } }
    }
}
