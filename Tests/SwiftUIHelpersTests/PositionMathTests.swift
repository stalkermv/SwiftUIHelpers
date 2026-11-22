import Testing
import SwiftUI
@testable import SwiftUIHelpers

// Argument tables live at file scope: `@Test(arguments:)` cannot reference
// actor-isolated statics, and these rows must be plain Sendable values.
private let projectedPointCases: [(unitPoint: UnitPoint, frame: CGRect, expectedPoint: CGPoint)] = [
    (.zero, CGRect(x: 10, y: 20, width: 100, height: 50), CGPoint(x: 10, y: 20)),
    (.center, CGRect(x: 0, y: 0, width: 100, height: 60), CGPoint(x: 50, y: 30)),
    (UnitPoint(x: 1, y: 1), CGRect(x: 5, y: 10, width: 80, height: 40), CGPoint(x: 85, y: 50)),
]

@Suite("Anchor point position", .tags(.layout))
@MainActor
struct PositionMathTests {
    @Test("Projected point resolves the unit point within the frame", arguments: projectedPointCases)
    func projectedPoint(unitPoint: UnitPoint, frame: CGRect, expectedPoint: CGPoint) {
        let point = AnchorPointPositionModifier.projectedPoint(unitPoint: unitPoint, frame: frame)
        #expect(abs(point.x - expectedPoint.x) < 0.001)
        #expect(abs(point.y - expectedPoint.y) < 0.001)
    }
}
