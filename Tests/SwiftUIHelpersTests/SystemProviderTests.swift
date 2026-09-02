import Testing
import SwiftUI
@testable import SwiftUIHelpers

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

// Argument table lives at file scope: `@Test(arguments:)` cannot reference
// actor-isolated statics, and these rows must be plain Sendable values.
private let descriptorAttributeCases: [(size: CGFloat, weight: PlatformFontWeight?, expectedHasTraits: Bool)] = [
    (18.0, nil, false),
    (14.0, .bold, true),
    (12.0, nil, false),
]

@Suite("System font provider", .tags(.fonts))
struct SystemProviderTests {
    @Test("Descriptor attributes carry the size, and traits only when a weight is given", arguments: descriptorAttributeCases)
    func descriptorAttributes(size: CGFloat, weight: PlatformFontWeight?, expectedHasTraits: Bool) {
        let attrs = SystemProvider.descriptorAttributes(size: size, weight: weight)
        #expect(attrs[.size] as? CGFloat == size)
        #expect((attrs[.traits] != nil) == expectedHasTraits)
    }
}
