//
//  ItalicModifier.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import UIKit

struct ItalicModifier: StaticFontModifier {
    init() {}

    func modify(_ fontDescriptor: inout UIFontDescriptor) {
        fontDescriptor = fontDescriptor.withSymbolicTraits(.traitItalic) ?? fontDescriptor
    }
}
