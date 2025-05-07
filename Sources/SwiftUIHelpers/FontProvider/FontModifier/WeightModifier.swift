//
//  WeightModifier.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import UIKit

struct WeightModifier: FontModifier {
    let weight: UIFont.Weight
    
    func modify(_ fontDescriptor: inout UIFontDescriptor) {
        fontDescriptor = fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
    }
}
