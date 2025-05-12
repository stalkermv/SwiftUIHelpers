//
//  Created by Valeriy Malishevskyi on 19.03.2024.
//

import SwiftUI

extension Binding {
    /// Creates a new `Binding` to an `Element` of a collection that can be identified by a specific key.
    ///
    /// This initializer creates a binding to a specific element within a collection. The element is identified using
    /// a `KeyPath` of the element to its identifier. This is useful in scenarios where you need a `Binding` to
    /// an optional element of a collection, allowing you to work with the selection state in a SwiftUI view.
    ///
    /// - Parameters:
    ///   - target: A `Binding` to an optional `Element`, typically representing the currently selected item.
    ///   - key: A `KeyPath` from the `Element` type to its identifier (`ID`), used to uniquely identify elements in the collection.
    ///   - collection: A collection of `Element` objects, from which the target element is selected.
    ///
    /// - Precondition:
    ///   - `Element` must conform to `Identifiable` protocol, and `ID` must match `Element`'s associated identifier type.
    ///   - The `Value` type of this binding extension must be compatible with `ID?`, representing an optional identifier.
    ///   - `C` must be a `Collection` where its elements are of type `Element`.
    ///
    /// This initializer enhances the `Binding` type with the ability to directly bind to an identifiable element within
    /// a collection, simplifying state management in SwiftUI views, especially when dealing with selections in lists
    /// or grids. The binding will automatically update when the selected `ID` changes, ensuring the UI stays in sync
    /// with the underlying data model.
    @MainActor public init<Element, ID, C>(
        _ target: Binding<Element?>,
        key: KeyPath<Element, ID>,
        in collection: C
    ) where Element: Identifiable, ID == Element.ID, Value == ID?, C: Collection, C.Element == Element{
        self.init(
            get: {
                target.wrappedValue?[keyPath: key]
            },
            set: { id in
                if let newId = id, target.wrappedValue?[keyPath: key] != newId {
                    target.wrappedValue = collection.first { $0[keyPath: key] == newId }
                }
            }
        )
    }
}
