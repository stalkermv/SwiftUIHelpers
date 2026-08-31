import SwiftUI

/// A container that tracks pointer hover state and propagates it to descendants
/// via `@Environment(\.isGroupHovering)`.
///
/// Wrap any region that should react to pointer hover with `HoverGroup` or the
/// `.hoverGroup()` modifier. Descendants read `@Environment(\.isGroupHovering)`
/// to show, hide, or style content when the pointer is inside the group.
///
/// ```swift
/// HoverGroup {
///     HStack {
///         Text("Item")
///         Image(systemName: "arrow.right")
///             .opacity(isGroupHovering ? 1 : 0)
///     }
/// }
/// ```
public struct HoverGroup<Content: View>: View {
    public let content: Content
    @State private var isHovering = false

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .contentShape(.rect)
            .onHover { isHovering = $0 }
            .environment(\.isGroupHovering, isHovering)
    }
}

public extension View {
    /// Marks this region as hover-aware.
    ///
    /// Descendants can read `@Environment(\.isGroupHovering)` to react when
    /// the pointer enters or exits this region.
    func hoverGroup() -> some View {
        HoverGroup { self }
    }
}