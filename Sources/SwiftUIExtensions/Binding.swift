//
//  Created by Valeriy Malishevskyi on 19.03.2024.
//

import SwiftUI

extension Binding {
    /// Creates a `Binding` to an `Element` identified by a key-path within a collection.
    ///
    /// **Snapshot semantics:** `collection` is captured at call-site; changes to the
    /// collection after binding creation are not reflected.
    ///
    /// **Setter behaviour:**
    /// - `nil` → writes `nil` to `target`, clearing the selection.
    /// - Non-nil ID → performs a first-match lookup in the captured collection; if
    ///   found, updates `target`; if not found (unknown ID), the setter is a no-op.
    ///
    /// - Parameters:
    ///   - target: A `Binding` to an optional `Element` representing the current selection.
    ///   - key: A `KeyPath` from `Element` to its identifier.
    ///   - collection: The collection to search for matching elements (snapshot).
    @MainActor public init<Element, ID, C>(
        _ target: Binding<Element?>,
        key: KeyPath<Element, ID>,
        in collection: C
    ) where Element: Identifiable, ID == Element.ID, Value == ID?, C: Collection, C.Element == Element {
        self.init(
            get: {
                target.wrappedValue?[keyPath: key]
            },
            set: { id in
                guard let newId = id else {
                    target.wrappedValue = nil
                    return
                }
                if let match = collection.first(where: { $0[keyPath: key] == newId }) {
                    target.wrappedValue = match
                }
                // Unknown ID → no-op
            }
        )
    }
}
