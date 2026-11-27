//
//  View+DefaultScrollAnchor.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 28.09.2024.
//

import SwiftUI

extension View {
    public func defaultScrollAnchor(index: Int, count: Int) -> some View {
        modifier(DefaultScrollAnchorModifier(index: index, count: count))
    }
}

struct DefaultScrollAnchorModifier: ViewModifier {
    var index: Int
    var count: Int

    func body(content: Content) -> some View {
        content.defaultScrollAnchor(DefaultScrollAnchorModifier.anchor(index: index, count: count))
    }

    /// Returns the scroll anchor for the given index and count.
    ///
    /// Returns `nil` when `count <= 1` or `index` is out of bounds.
    static func anchor(index: Int, count: Int) -> UnitPoint? {
        guard count > 1, index >= 0, index < count else { return nil }
        let offset = CGFloat(index) / CGFloat(count - 1)
        return UnitPoint(x: offset, y: 0.5)
    }
}
