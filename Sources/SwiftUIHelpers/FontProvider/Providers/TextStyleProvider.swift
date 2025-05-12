//
//  TextStyleProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

struct TextStyleProvider: FontProvider {
    let style: PlatformTextStyle
    let design: PlatformSystemDesign?
    let weight: PlatformFontWeight?
    
    func fontDescriptor(with traitCollection: PlatformTraitCollection?) -> PlatformFontDescriptor {
        #if canImport(UIKit)
        var descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style, compatibleWith: traitCollection)
        #else
        var descriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: style)
        #endif
        
        if let design = design {
            descriptor = descriptor.withDesign(design) ?? descriptor
        }
        
        if let weight = weight {
            var traits: [PlatformFontDescriptor.TraitKey: Any] = [:]
            #if canImport(UIKit)
            if let existingTraits = descriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any] {
                traits = existingTraits
            }
            traits[.weight] = weight
            descriptor = descriptor.addingAttributes([.traits: traits])
            #else
            if let existingTraits = descriptor.object(forKey: .traits) as? [NSFontDescriptor.TraitKey: Any] {
                traits = existingTraits
            }
            traits[.weight] = weight
            descriptor = descriptor.addingAttributes([.traits: traits])
            #endif
        }
        
        return descriptor
    }
}
