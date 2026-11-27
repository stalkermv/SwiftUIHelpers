//
//  View+Hidden.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 18.08.2024.
//

import SwiftUI

extension View {

    /// Hides or shows the view based on a boolean value.
    ///
    /// When `isHidden` is `true` and `remove` is `false`, the view keeps its
    /// layout space (opacity 0, accessibility hidden). When `remove` is `true`,
    /// the view is replaced with an `EmptyView`.
    ///
    /// Example:
    ///
    ///     Text("Label")
    ///         .hidden(true)
    ///
    ///     Text("Label")
    ///         .hidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - isHidden: `true` to hide the view; `false` to show it.
    ///   - transition: The transition to apply. Defaults to `.identity`.
    ///   - remove: When `true`, replaces the view with `EmptyView` instead of
    ///     hiding it in place.
    @inlinable
    public func hidden(
        _ isHidden: Bool,
        transition: AnyTransition = .identity,
        remove: Bool = false
    ) -> some View {
        modifier(
            HiddenModifier(
                isHidden: isHidden,
                transition: transition,
                remove: remove
            )
        )
    }
}

/// Determines whether a view should be removed, hidden, or shown.
enum VisibilityDecision {
    case removed
    case hidden
    case visible

    /// Returns the visibility decision for the given parameters.
    static func decision(isHidden: Bool, remove: Bool) -> VisibilityDecision {
        if isHidden && remove { return .removed }
        if isHidden { return .hidden }
        return .visible
    }
}

public struct HiddenModifier: ViewModifier {

    public var isHidden: Bool
    public var remove: Bool
    public var transition: AnyTransition

    /// Creates a `HiddenModifier`.
    ///
    /// - Parameters:
    ///   - isHidden: Whether the view should be hidden.
    ///   - transition: The transition to apply. Defaults to `.identity`.
    ///   - remove: When `true`, replaces the view with `EmptyView`.
    @inlinable
    public init(
        isHidden: Bool,
        transition: AnyTransition = .identity,
        remove: Bool = false
    ) {
        self.isHidden = isHidden
        self.transition = transition
        self.remove = remove
    }

    public func body(content: Content) -> some View {
        switch VisibilityDecision.decision(isHidden: isHidden, remove: remove) {
        case .removed:
            EmptyView()
        case .hidden:
            content
                .opacity(0)
                .accessibilityHidden(true)
                .transition(transition)
        case .visible:
            content
                .transition(transition)
        }
    }
}
