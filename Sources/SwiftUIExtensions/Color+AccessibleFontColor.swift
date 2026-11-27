//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
typealias PlatformColor = UIColor
#else
import AppKit
typealias PlatformColor = NSColor
#endif

public extension Color {
    /// Returns `.black` or `.white` — whichever provides higher contrast against
    /// this color — calculated using the WCAG 2.1 relative luminance formula.
    ///
    /// Supported on iOS, macOS, and macCatalyst.
    var accessibleFontColor: Color {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        #if canImport(UIKit)
        guard PlatformColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return .black
        }
        #else
        guard let srgb = PlatformColor(self).usingColorSpace(.sRGB) else {
            return .black
        }
        srgb.getRed(&red, green: &green, blue: &blue, alpha: nil)
        #endif
        func linearize(_ c: CGFloat) -> CGFloat {
            c <= 0.03928 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4)
        }
        let L = 0.2126 * linearize(red)
              + 0.7152 * linearize(green)
              + 0.0722 * linearize(blue)
        return L > 0.179 ? .black : .white
    }
}
