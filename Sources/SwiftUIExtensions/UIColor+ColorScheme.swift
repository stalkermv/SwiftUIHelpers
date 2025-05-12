//
//  UIColor+ColorScheme.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 05.08.2024.
//

#if canImport(UIKit)
import SwiftUI

extension UIColor {

    /// Initializes a dynamic color that adapts to the current user interface style (light or dark mode).
    ///
    /// This initializer allows you to provide separate color values for light and dark appearances.
    /// The system automatically chooses the appropriate color at runtime based on the current
    /// `UITraitCollection`.
    ///
    /// ```swift
    /// let backgroundColor = UIColor(
    ///     light: .white,
    ///     dark: .black
    /// )
    /// ```
    ///
    /// - Parameters:
    ///   - light: The color to use in light mode or when the interface style is unspecified.
    ///   - dark: The color to use in dark mode.
    public convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return light
            case .dark:
                return dark
            @unknown default:
                return light
            }
        }
    }
}
#endif
