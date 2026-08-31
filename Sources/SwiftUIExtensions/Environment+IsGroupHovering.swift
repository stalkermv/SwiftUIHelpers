import SwiftUI

struct IsGroupHoveringEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    /// Whether the enclosing `hoverGroup()` has the pointer over it.
    ///
    /// Set to `true` when a `HoverGroup` view reports that the pointer is
    /// inside its content area. Descendants can read this value to show or
    /// hide content in response to hover state.
    var isGroupHovering: Bool {
        get { self[IsGroupHoveringEnvironmentKey.self] }
        set { self[IsGroupHoveringEnvironmentKey.self] = newValue }
    }
}