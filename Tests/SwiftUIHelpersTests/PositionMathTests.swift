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

/// Frames as a nonlocal coordinate space (global or a named space) reports them.
/// The expected point is always parent-local, the coordinates `.position(_:)` takes.
private let localPointCases: [(unitPoint: UnitPoint, frame: CGRect, localSize: CGSize, expectedPoint: CGPoint)] = [
    // Global frame offset by (100, 200): center must stay in the middle of the local frame.
    (.center, CGRect(x: 100, y: 200, width: 300, height: 400), CGSize(width: 300, height: 400), CGPoint(x: 150, y: 200)),
    (.zero, CGRect(x: 100, y: 200, width: 300, height: 400), CGSize(width: 300, height: 400), CGPoint(x: 0, y: 0)),
    (.bottomTrailing, CGRect(x: -40, y: 15, width: 80, height: 20), CGSize(width: 80, height: 20), CGPoint(x: 80, y: 20)),
    // Local space: origin is zero, so the result matches the projected point.
    (.center, CGRect(x: 0, y: 0, width: 100, height: 60), CGSize(width: 100, height: 60), CGPoint(x: 50, y: 30)),
    // Scaled ancestor: the measured frame is twice the local size.
    (.center, CGRect(x: 10, y: 10, width: 200, height: 100), CGSize(width: 100, height: 50), CGPoint(x: 50, y: 25)),
    // Degenerate frame keeps finite coordinates.
    (.center, CGRect(x: 30, y: 40, width: 0, height: 0), CGSize.zero, CGPoint(x: 0, y: 0)),
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

    @Test("Positioned point is converted to parent-local coordinates", arguments: localPointCases)
    func localPoint(unitPoint: UnitPoint, frame: CGRect, localSize: CGSize, expectedPoint: CGPoint) {
        let point = AnchorPointPositionModifier.localPoint(unitPoint: unitPoint, frame: frame, localSize: localSize)
        #expect(abs(point.x - expectedPoint.x) < 0.001)
        #expect(abs(point.y - expectedPoint.y) < 0.001)
    }
}

/// `position(point:)` is the API to use; this keeps it compiling.
private struct PositionPointUsage: View {
    var body: some View {
        Color.red
            .frame(width: 10, height: 10)
            .position(point: .topTrailing)
    }
}
