//
//  NamedProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import UIKit

struct NamedProvider: FontProvider {
    var name: String

    var size: CGFloat

    var textStyle: UIFont.TextStyle?

    func fontDescriptor(with traitCollection: UITraitCollection?) -> UIFontDescriptor {
        if let textStyle = textStyle {
            let metrics = UIFontMetrics(forTextStyle: textStyle)

            return UIFontDescriptor(fontAttributes: [
                .family: name,
                .size: metrics.scaledValue(for: size, compatibleWith: traitCollection)
            ])
        } else {
            return UIFontDescriptor(fontAttributes: [
                .family: name,
                .size: size
            ])
        }
    }
}
