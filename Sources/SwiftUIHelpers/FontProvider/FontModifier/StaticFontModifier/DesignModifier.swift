import SwiftUI

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

struct DesignModifier: FontModifier {
    let design: PlatformSystemDesign
    
    init(_ design: Font.Design) {
        self.design = .init(design)
    }
    
    func modify(_ fontDescriptor: inout PlatformFontDescriptor) {
        fontDescriptor = fontDescriptor.withDesign(design) ?? fontDescriptor
    }
} 