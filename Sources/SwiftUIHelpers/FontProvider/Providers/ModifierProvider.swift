// FontProvider relies on UITraitCollection/UIFontMetrics, which watchOS does not have.
#if !os(watchOS)
//
//  ModifierProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI

struct ModifierProvider: FontProvider {
    let base: FontProvider
    let modifier: FontModifier
    
    func fontDescriptor(with traitCollection: PlatformTraitCollection?) -> PlatformFontDescriptor {
        var descriptor = base.fontDescriptor(with: traitCollection)

        modifier.modify(&descriptor)

        return descriptor
    }
}
#endif
