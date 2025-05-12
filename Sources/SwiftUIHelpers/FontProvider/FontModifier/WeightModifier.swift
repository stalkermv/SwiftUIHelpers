//
//  WeightModifier.swift
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

struct WeightModifier: FontModifier {
    let weight: PlatformFontWeight
    
    func modify(_ fontDescriptor: inout PlatformFontDescriptor) {
        #if canImport(UIKit)
        fontDescriptor = fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
        #else
        fontDescriptor = fontDescriptor.addingAttributes([.traits: [NSFontDescriptor.TraitKey.weight: weight]])
        #endif
    }
}

