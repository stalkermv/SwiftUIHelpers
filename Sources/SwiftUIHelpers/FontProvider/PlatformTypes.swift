import SwiftUI

#if canImport(UIKit)
import UIKit

public typealias PlatformFont = UIFont
public typealias PlatformFontDescriptor = UIFontDescriptor
public typealias PlatformTextStyle = UIFont.TextStyle
public typealias PlatformSystemDesign = UIFontDescriptor.SystemDesign
public typealias PlatformFontWeight = UIFont.Weight
public typealias PlatformTraitCollection = UITraitCollection
#else
import AppKit

public typealias PlatformFont = NSFont
public typealias PlatformFontDescriptor = NSFontDescriptor
public typealias PlatformTextStyle = NSFont.TextStyle
public typealias PlatformSystemDesign = NSFontDescriptor.SystemDesign
public typealias PlatformFontWeight = NSFont.Weight

// A simple trait collection for macOS to maintain API compatibility
public struct MacOSTraitCollection {
    let preferredContentSizeCategory: DynamicTypeSize
    
    init(preferredContentSizeCategory: DynamicTypeSize) {
        self.preferredContentSizeCategory = preferredContentSizeCategory
    }
}
public typealias PlatformTraitCollection = MacOSTraitCollection
#endif

extension PlatformTextStyle {
    init(_ style: Font.TextStyle) {
        #if canImport(UIKit)
        switch style {
        case .largeTitle: self = .largeTitle
        case .title: self = .title1
        case .title2: self = .title2
        case .title3: self = .title3
        case .headline: self = .headline
        case .body: self = .body
        case .callout: self = .callout
        case .subheadline: self = .subheadline
        case .footnote: self = .footnote
        case .caption: self = .caption1
        case .caption2: self = .caption2
        @unknown default: self = .body
        }
        #else
        switch style {
        case .largeTitle: self = .title1
        case .title: self = .title1
        case .title2: self = .title2
        case .title3: self = .title3
        case .headline: self = .headline
        case .body: self = .body
        case .callout: self = .body
        case .subheadline: self = .subheadline
        case .footnote: self = .footnote
        case .caption: self = .caption1
        case .caption2: self = .caption2
        @unknown default: self = .body
        }
        #endif
    }
}

extension PlatformFontWeight {
    init(_ weight: Font.Weight) {
        #if canImport(UIKit)
        switch weight {
        case .ultraLight: self = .ultraLight
        case .thin: self = .thin
        case .light: self = .light
        case .regular: self = .regular
        case .medium: self = .medium
        case .semibold: self = .semibold
        case .bold: self = .bold
        case .heavy: self = .heavy
        case .black: self = .black
        default: self = weight.rawValue
                .map(PlatformFont.Weight.init(rawValue:)) ?? .regular
        }
        #else
        switch weight {
        case .ultraLight: self = .ultraLight
        case .thin: self = .thin
        case .light: self = .light
        case .regular: self = .regular
        case .medium: self = .medium
        case .semibold: self = .semibold
        case .bold: self = .bold
        case .heavy: self = .heavy
        case .black: self = .black
        default: self = weight.rawValue
                .map(PlatformFont.Weight.init(rawValue:)) ?? .regular
        }
        #endif
    }
}

extension Font.Weight {
    var rawValue: CGFloat? {
        let mirror = Mirror(reflecting: self)
        let value = mirror.children.first?.value as? CGFloat
        return value
    }
}

extension PlatformSystemDesign {
    init(_ design: Font.Design) {
        #if canImport(UIKit)
        switch design {
        case .default: self = .default
        case .serif: self = .serif
        case .rounded: self = .rounded
        case .monospaced: self = .monospaced
        @unknown default: self = .default
        }
        #else
        switch design {
        case .default: self = .default
        case .serif: self = .serif
        case .rounded: self = .rounded
        case .monospaced: self = .monospaced
        @unknown default: self = .default
        }
        #endif
    }
} 
