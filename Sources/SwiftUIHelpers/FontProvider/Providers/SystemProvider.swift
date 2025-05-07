//
//  SystemProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI

struct SystemProvider: FontProvider {
    var size: CGFloat

    var design: UIFontDescriptor.SystemDesign

    var weight: UIFont.Weight?

    func fontDescriptor(with traitCollection: UITraitCollection?) -> UIFontDescriptor {
        UIFont
            .preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
            .fontDescriptor
            .withDesign(design)!
            .addingAttributes([
                .size: size
            ])
    }
}
