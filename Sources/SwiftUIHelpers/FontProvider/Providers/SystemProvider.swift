//
//  SystemProvider.swift
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

struct SystemProvider: FontProvider {
    var size: CGFloat
    var design: PlatformSystemDesign
    var weight: PlatformFontWeight?

    func fontDescriptor(with traitCollection: PlatformTraitCollection?) -> PlatformFontDescriptor {
        #if canImport(UIKit)
        let descriptor = UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection).fontDescriptor
        #else
        let descriptor = NSFont.systemFont(ofSize: NSFont.systemFontSize).fontDescriptor
        #endif
        
        var attributes: [PlatformFontDescriptor.AttributeName: Any] = [.size: size]
        
        if let weight = weight {
            #if canImport(UIKit)
            attributes[.traits] = [UIFontDescriptor.TraitKey.weight: weight]
            #else
            attributes[.traits] = [NSFontDescriptor.TraitKey.weight: weight]
            #endif
        }
        
        return descriptor
            .withDesign(design)?
            .addingAttributes(attributes) ?? descriptor
    }
}
