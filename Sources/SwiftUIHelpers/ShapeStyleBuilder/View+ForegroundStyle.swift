//
//  View+ForegroundStyle.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 07.06.2025.
//

import SwiftUI

extension View {
    /// Applies a foreground style to the view using a `ShapeStyleBuilder`.
    @available(iOS 15.0, *)
    public func foregroundStyle<S>(@ShapeStyleBuilder _ style: () -> S) -> some View
    where S : ShapeStyle {
        let style = style()
        return self.foregroundStyle(style)
    }
    
    @available(iOS 16.0, *)
    public func tint<S>(_ tint: S) -> some View where S : ShapeStyle {
        self.tint(Optional(tint))
    }
}
