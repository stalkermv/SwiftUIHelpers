import SwiftUI
import Testing

#if canImport(UIKit)
import UIKit
typealias PlatColor = UIColor
#else
import AppKit
typealias PlatColor = NSColor
#endif

@MainActor final class ValueBox<T> {
    var value: T
    init(_ value: T) { self.value = value }
    var binding: Binding<T> {
        Binding(get: { self.value }, set: { self.value = $0 })
    }
}

func components(of color: Color) -> (r: CGFloat, g: CGFloat, b: CGFloat)? {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    #if canImport(UIKit)
    guard PlatColor(color).getRed(&r, green: &g, blue: &b, alpha: &a) else { return nil }
    #else
    guard let srgb = PlatColor(color).usingColorSpace(.sRGB) else { return nil }
    srgb.getRed(&r, green: &g, blue: &b, alpha: &a)
    #endif
    return (r, g, b)
}
