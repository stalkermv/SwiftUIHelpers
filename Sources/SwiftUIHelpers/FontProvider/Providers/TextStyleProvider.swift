//
//  TextStyleProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import UIKit

struct TextStyleProvider: FontProvider {
    func fontDescriptor(with traitCollection: UITraitCollection?) -> UIFontDescriptor {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        
        if let design = design {
            descriptor.withDesign(design)
        }
        
        if let weight = weight {
            descriptor.withSymbolicTraits(.traitBold)
        }
        
        return descriptor
    }
    
    let style: UIFont.TextStyle
    let design: UIFontDescriptor.SystemDesign?
    let weight: UIFont.Weight?
}
