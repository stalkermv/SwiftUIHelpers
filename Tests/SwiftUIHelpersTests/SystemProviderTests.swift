import Testing
import SwiftUI
@testable import SwiftUIHelpers

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

struct SystemProviderTests {
    @Test func descriptorAttributes_containsSize() {
        let attrs = SystemProvider.descriptorAttributes(size: 18.0, weight: nil)
        let size = attrs[.size] as? CGFloat
        #expect(size == 18.0)
    }

    @Test func descriptorAttributes_withWeight_containsTraits() {
        let attrs = SystemProvider.descriptorAttributes(size: 14.0, weight: .bold)
        #expect(attrs[.traits] != nil)
        #expect(attrs[.size] as? CGFloat == 14.0)
    }

    @Test func descriptorAttributes_noWeight_noTraits() {
        let attrs = SystemProvider.descriptorAttributes(size: 12.0, weight: nil)
        #expect(attrs[.traits] == nil)
    }
}
