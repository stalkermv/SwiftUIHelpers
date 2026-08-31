//
//  Binding+Equals.swift
//
//  Created by Valeriy Malishevskyi on 21.08.2023.
//

import SwiftUI

public extension Binding {
    /// Returns a boolean binding that is `true` when this optional binding equals `value`.
    ///
    /// - Setting to `true` writes `value` into the original binding.
    /// - Setting to `false` writes `nil` only when the current value equals `value`; otherwise no-op.
    ///
    /// Example:
    /// ```swift
    /// enum SelectedArea {
    ///     case top
    ///     case bottom
    /// }
    /// @State var selected: SelectedArea? = .top
    ///
    /// var body: some View {
    ///     Text("Hello, World!")
    ///         .sheet(isPresented: $selected.equals(.bottom)) {
    ///             Text("Sheet Content")
    ///         }
    /// }
    /// ```
    ///
    /// - Parameter value: The value to compare against.
    func equals<Wrapped: Hashable & Sendable>(_ value: Wrapped) -> Binding<Bool> where Value == Wrapped? {
        Binding<Bool> {
            wrappedValue == value
        } set: { newValue in
            if newValue {
                self.wrappedValue = value
            } else if self.wrappedValue == value {
                self.wrappedValue = nil
            }
        }
    }
}
