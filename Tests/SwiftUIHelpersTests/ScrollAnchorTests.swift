import Testing
import SwiftUI
@testable import SwiftUIHelpers

// Argument tables live at file scope: `@Test(arguments:)` cannot reference
// actor-isolated statics, and these rows must be plain Sendable values.
private let noAnchorCases: [(index: Int, count: Int)] = [
    (0, 0), // count 0: nothing to anchor to
    (0, 1), // count 1: a single item has no meaningful anchor
    (-1, 5), // index below range
    (5, 5), // index at/above range (last valid index is 4)
]

private let anchorValueCases: [(index: Int, count: Int, expectedX: CGFloat)] = [
    (0, 2, 0.0), // first of two → leading edge
    (1, 2, 1.0), // second of two → trailing edge
    (2, 5, 0.5), // middle of five → centered
    (1, 3, 0.5), // middle of three → centered (also covers the y invariant below)
]

@MainActor
@Suite("Default scroll anchor", .tags(.scroll))
struct ScrollAnchorTests {
    @Test("Out-of-range or too-small counts produce no anchor", arguments: noAnchorCases)
    func noAnchor(index: Int, count: Int) {
        #expect(DefaultScrollAnchorModifier.anchor(index: index, count: count) == nil)
    }

    @Test("A valid index resolves an anchor with the expected x and a centered y", arguments: anchorValueCases)
    func anchorPosition(index: Int, count: Int, expectedX: CGFloat) throws {
        let anchor = try #require(DefaultScrollAnchorModifier.anchor(index: index, count: count))
        #expect(abs(anchor.x - expectedX) < 0.001)
        #expect(abs(anchor.y - 0.5) < 0.001)
    }
}
