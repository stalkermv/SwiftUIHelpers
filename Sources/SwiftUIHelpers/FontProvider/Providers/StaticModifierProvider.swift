//
//  StaticModifierProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI

struct StaticModifierProvider<M: StaticFontModifier>: FontProvider {
    var base: FontProvider

    func fontDescriptor(with traitCollection: UITraitCollection?) -> UIFontDescriptor {
        var descriptor = base.fontDescriptor(with: traitCollection)

        M().modify(&descriptor)

        return descriptor
    }
}
