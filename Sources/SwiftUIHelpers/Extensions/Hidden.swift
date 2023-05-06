//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import SwiftUI

public extension View {

    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .hidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .hidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func hidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    /// Hides or shows the view based on the specified boolean value, and displays a placeholder view when hidden.
    ///
    /// - Parameters:
    ///   - hidden: A boolean value indicating whether to hide (`true`) or show (`false`) the view.
    ///   - remove: A boolean value indicating whether or not to remove the view.
    ///   - placeholder: A closure returning a `View` to display when the main view is hidden.
    ///
    /// - Returns: A `ViewBuilder` containing the modified `View`.
    @ViewBuilder func hidden<V: View>(_ hidden: Bool, remove: Bool = false, placeholder: () -> V) -> some View {
        if hidden {
            if !remove {
                self.hidden()
                .overlay(placeholder())
            } else {
                placeholder()
            }
        } else {
            self
        }
    }
    
    /// Hides or shows the view based on the specified optional boolean value, and displays a placeholder view when hidden.
    ///
    /// - Parameters:
    ///   - hidden: An optional boolean value indicating whether to hide (`true`) or show (`false`) the view.
    ///   - remove: A boolean value indicating whether or not to remove the view.
    ///   - placeholder: A closure returning a `View` to display when the main view is hidden.
    ///
    /// - Returns: A `ViewBuilder` containing the modified `View`.
    @ViewBuilder func hidden<V: View>(_ hidden: Bool?, remove: Bool = false, placeholder: () -> V) -> some View {
        if let hidden {
            self.hidden(hidden, remove: remove, placeholder: placeholder)
        } else {
            self
        }
    }
}
