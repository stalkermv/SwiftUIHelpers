import SwiftUI

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

protocol FontProvider {
    func fontDescriptor(with traitCollection: PlatformTraitCollection?) -> PlatformFontDescriptor
    func font(with traitCollection: PlatformTraitCollection?) -> PlatformFont
}

extension FontProvider {
    func font(with traitCollection: PlatformTraitCollection?) -> PlatformFont {
        #if canImport(UIKit)
        return UIFont(descriptor: fontDescriptor(with: traitCollection), size: 0)
        #else
        return NSFont(descriptor: fontDescriptor(with: traitCollection), size: 0) ?? .systemFont(ofSize: NSFont.systemFontSize)
        #endif
    }
} 
