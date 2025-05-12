//
//  BoldModifier.swift
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

struct BoldModifier: StaticFontModifier {
    init() {}

    func modify(_ fontDescriptor: inout PlatformFontDescriptor) {
        #if canImport(UIKit)
        fontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor
        #else
        fontDescriptor = fontDescriptor.withSymbolicTraits(.bold)
        #endif
    }
}
