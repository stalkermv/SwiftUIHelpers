//
//  EdgeInsets+Init.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 01.08.2024.
//

import SwiftUI

extension EdgeInsets {

    /// Initializes `EdgeInsets` with equal horizontal and vertical padding.
    ///
    /// This initializer simplifies creating symmetrical insets by applying the same horizontal
    /// value to both `leading` and `trailing`, and the same vertical value to both `top` and `bottom`.
    ///
    /// ```swift
    /// let insets = EdgeInsets(horizontal: 16, vertical: 8)
    /// // Equivalent to: EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    /// ```
    ///
    /// - Parameters:
    ///   - horizontal: The inset value for both `leading` and `trailing`. Defaults to `0`.
    ///   - vertical: The inset value for both `top` and `bottom`. Defaults to `0`.
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
