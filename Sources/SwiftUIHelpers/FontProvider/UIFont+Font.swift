//
//  UIFont+Font.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI
import SwiftUIExtensions
import UIKit

extension UIFont {
    public static func resolving(font: Font, dynamicTypeSize: DynamicTypeSize = .medium) -> UIFont {
        let traits = UITraitCollection(traitsFrom: [
            .init(preferredContentSizeCategory: UIContentSizeCategory(dynamicTypeSize))
        ])
        
        if let provider = font.getFontProvider() {
            return provider.font(with: traits)
        }
        
        return .preferredFont(forTextStyle: .body)
    }
}

extension Font {
    func getFontProvider() -> FontProvider? {
        let mirror = Mirror(reflecting: self)

        guard let provider = mirror.descendant("provider", "base") else {
            return nil
        }
        
        return resolveFontProvider(provider)
    }

    private func resolveFontProvider(_ provider: Any) -> FontProvider? {
        let mirror = Mirror(reflecting: provider)

        switch String(describing: type(of: provider)) {
        case "StaticModifierProvider<ItalicModifier>":
            guard let base = mirror.descendant("base", "provider", "base") else {
                return nil
            }

            return resolveFontProvider(base).map(StaticModifierProvider<ItalicModifier>.init)
        case "StaticModifierProvider<BoldModifier>":
            guard let base = mirror.descendant("base", "provider", "base") else {
                return nil
            }

            return resolveFontProvider(base).map(StaticModifierProvider<BoldModifier>.init)
        case "SystemProvider":
            guard let size = mirror.descendant("size") as? CGFloat,
                  let design = mirror.descendant("design") as? Font.Design else {
                return nil
            }

            let weight = mirror.descendant("weight") as? Font.Weight

            return SystemProvider(size: size, design: .init(design), weight: weight.map(UIFont.Weight.init))
        case "NamedProvider":
            guard let name = mirror.descendant("name") as? String,
                  let size = mirror.descendant("size") as? CGFloat else {
                return nil
            }
            
            let textStyle = mirror.descendant("textStyle") as? Font.TextStyle
            
            return NamedProvider(name: name, size: size, textStyle: textStyle.map(UIFont.TextStyle.init))
        case "TextStyleProvider":
            guard let style = mirror.descendant("style") as? Font.TextStyle else {
                return nil
            }
            
            let design = mirror.descendant("design") as? Font.Design
            let weight = mirror.descendant("weight") as? Font.Weight
            
            return TextStyleProvider(
                style: .init(style),
                design: design.map(UIFontDescriptor.SystemDesign.init),
                weight: weight.map(UIFont.Weight.init)
            )
        case "ModifierProvider<WeightModifier>":
            guard let base = mirror.descendant("base") as? Font,
                  let provider = base.getFontProvider() else {
                return nil
            }
            
            let weight = mirror.descendant("modifier", "weight") as! Font.Weight
            let weightModifier = WeightModifier(weight: .init(weight))
            
            return ModifierProvider.init(base: provider, modifier: weightModifier)
        default:
            // Not exhaustive, more providers need to be handled here.

            print("Unknown font provider: \(provider)")
            return nil
        }
    }
}
