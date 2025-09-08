//
//  View+Hidden.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 18.08.2024.
//

import SwiftUI

extension View {

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

public struct HiddenModifier: ViewModifier {

    public var isHidden: Bool
    public var remove: Bool
    public var transition: AnyTransition

    @inlinable
    public init(
        isHidden: Bool,
        transition: AnyTransition = .opacity,
        remove: Bool = false
    ) {
        self.isHidden = isHidden
        self.transition = transition
        self.remove = remove
    }

    public func body(content: Content) -> some View {
        if isHidden && remove {
            EmptyView()
        } else {
            if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
                content
                    .transaction { transaction in
                        transaction.animation = .none
                    } body: { content in
                        content
                            .opacity(isHidden ? 0 : 1)
                    }
                    .transition(transition)
            } else {
                content
                    .transition(transition)
            }
        }
    }
}
