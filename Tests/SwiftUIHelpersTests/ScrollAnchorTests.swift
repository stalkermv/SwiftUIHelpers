import Testing
import SwiftUI
@testable import SwiftUIHelpers

struct ScrollAnchorTests {
    @Test func count0_returns_nil() {
        #expect(DefaultScrollAnchorModifier.anchor(index: 0, count: 0) == nil)
    }
    @Test func count1_returns_nil() {
        #expect(DefaultScrollAnchorModifier.anchor(index: 0, count: 1) == nil)
    }
    @Test func count2_index0_returns_leading() {
        let p = DefaultScrollAnchorModifier.anchor(index: 0, count: 2)
        #expect(p != nil)
        #expect(abs(p!.x - 0.0) < 0.001)
    }
    @Test func count2_index1_returns_trailing() {
        let p = DefaultScrollAnchorModifier.anchor(index: 1, count: 2)
        #expect(p != nil)
        #expect(abs(p!.x - 1.0) < 0.001)
    }
    @Test func count5_index2_returns_half() {
        let p = DefaultScrollAnchorModifier.anchor(index: 2, count: 5)
        #expect(p != nil)
        #expect(abs(p!.x - 0.5) < 0.001)
    }
    @Test func outOfRange_negative_returns_nil() {
        #expect(DefaultScrollAnchorModifier.anchor(index: -1, count: 5) == nil)
    }
    @Test func outOfRange_tooLarge_returns_nil() {
        #expect(DefaultScrollAnchorModifier.anchor(index: 5, count: 5) == nil)
    }
    @Test func yIsAlways_half() {
        let p = DefaultScrollAnchorModifier.anchor(index: 1, count: 3)
        #expect(abs(p!.y - 0.5) < 0.001)
    }
}
