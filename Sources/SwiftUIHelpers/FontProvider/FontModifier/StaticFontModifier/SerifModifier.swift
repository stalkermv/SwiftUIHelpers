// FontProvider relies on UITraitCollection/UIFontMetrics, which watchOS does not have.
#if !os(watchOS)
import SwiftUI

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

struct SerifModifier: StaticFontModifier {
    init() {}
    
    func modify(_ fontDescriptor: inout PlatformFontDescriptor) {
        let designModifier = DesignModifier(.serif)
        designModifier.modify(&fontDescriptor)
    }
}
#endif
