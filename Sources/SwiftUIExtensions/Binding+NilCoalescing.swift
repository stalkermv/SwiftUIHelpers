//
//  Binding+??.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 14.07.2024.
//

import SwiftUI

public extension Binding where Value: Sendable {
    /// Create a non-optional version of an optional `Binding` with a default value
    /// - Parameters:
    ///   - lhs: The original `Binding<Value?>` (binding to an optional value)
    ///   - rhs: The default value if the original `wrappedValue` is `nil`
    /// - Returns: The `Binding<Value>` (where `Value` is non-optional)
    static func ??(
        lhs: Binding<Optional<Value>>,
        rhs: @autoclosure @Sendable @escaping () -> Value
    ) -> Binding<Value> {
        Binding(
            get: { lhs.wrappedValue ?? rhs() },
            set: { lhs.wrappedValue = $0 }
        )
    }
}
