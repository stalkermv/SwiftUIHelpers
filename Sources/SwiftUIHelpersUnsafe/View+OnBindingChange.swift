//
//  Created by Valeriy Malishevskyi on 05.11.2026.
//

import SwiftUI

extension View {
    /// Calls `action` when the value of `binding` changes.
    ///
    /// Wraps the underscored SwiftUI API `_onBindingChange(_:perform:)`. Not covered by semver.
    public func onBindingChange<Value: Equatable>(
        _ binding: Binding<Value>,
        perform action: @escaping (Value) -> Void
    ) -> some View {
        _onBindingChange(binding, perform: action)
    }
}
