//
//  Shape+Fill.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 22.07.2025.
//

import SwiftUI

extension Shape {
    @_disfavoredOverload
    public func fill<S>(
        @ShapeStyleBuilder _ content: () -> S,
        style: FillStyle = FillStyle()
    ) -> some View where S : ShapeStyle {
        let content = content()
        return self.fill(content, style: style)
    }
}
