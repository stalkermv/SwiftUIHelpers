//
//  Created by Valeriy Malishevskyi on 05.11.2026.
//

import SwiftUI

extension View {
    /// Calls `action` when the environment value at `keyPath` changes.
    ///
    /// Wraps the underscored SwiftUI API `_onEnvironmentChange(_:perform:)`. Not covered by semver.
    public func onEnvironmentChange<Value: Equatable>(
        _ keyPath: KeyPath<EnvironmentValues, Value>,
        perform action: @escaping (_ newValue: Value) -> Void
    ) -> some View {
        _onEnvironmentChange(keyPath, perform: action)
    }

    /// Calls `action` with the old and new value when the environment value at `keyPath` changes.
    ///
    /// Wraps the underscored SwiftUI API `_onEnvironmentChange(_:perform:)`. Not covered by semver.
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
    public func onEnvironmentChange<Value: Equatable>(
        _ keyPath: KeyPath<EnvironmentValues, Value>,
        perform action: @escaping (_ oldValue: Value?, _ newValue: Value) -> Void
    ) -> some View {
        _onEnvironmentChange(keyPath, perform: action)
    }
}
