import Testing
import CoreGraphics
@testable import SwiftUIHelpers

/// `resolvedDetentHeight` resets its tracked safe-area inset when either:
/// - `abs(safeAreaTop - trackedSafeAreaTop) > 16` (a significant jump, e.g. rotation), or
/// - `trackedSafeAreaTop != 0 && safeAreaTop == 0` (the inset disappeared entirely).
///
/// Otherwise the previous tracked value is kept. `height` always equals
/// `frameHeight + safeAreaTop`, regardless of the reset decision.
private let resolvedDetentHeightCases: [(
    frameHeight: CGFloat, safeAreaTop: CGFloat, trackedSafeAreaTop: CGFloat,
    expectedHeight: CGFloat, expectedSafeAreaTop: CGFloat
)] = [
    (400, 44, 44, 444, 44), // delta 0, tracked already in sync → no reset
    (400, 50, 44, 450, 44), // delta 6 < 16 → no reset, tracked stays 44
    (400, 0, 44, 400, 0), // delta 44 > 16 → reset, tracked becomes 0
    (300, 0, 5, 300, 0), // tracked 5 ≠ 0, new 0 → reset even though delta 5 < 16
    (300, 0, 0, 300, 0), // tracked already 0 → no reset needed, stays 0
    (500, 20, 20, 520, 20), // delta 0 → no reset; height still includes the inset
]

@Suite("Fit presentation detent", .tags(.detents))
@MainActor
struct DetentGeometryTests {
    @Test("Resolved detent height applies the safe-area reset threshold", arguments: resolvedDetentHeightCases)
    func resolvedDetentHeight(
        frameHeight: CGFloat, safeAreaTop: CGFloat, trackedSafeAreaTop: CGFloat,
        expectedHeight: CGFloat, expectedSafeAreaTop: CGFloat
    ) {
        let result = FitPresentationDetentModifier.resolvedDetentHeight(
            frameHeight: frameHeight, safeAreaTop: safeAreaTop, trackedSafeAreaTop: trackedSafeAreaTop)
        #expect(result.height == expectedHeight)
        #expect(result.safeAreaTop == expectedSafeAreaTop)
    }
}
