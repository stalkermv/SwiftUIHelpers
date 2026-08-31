import Testing
import SwiftUI
@testable import SwiftUIHelpers

struct PositionMathTests {
    @Test func zero_unitPoint_returns_origin() {
        let frame = CGRect(x: 10, y: 20, width: 100, height: 50)
        let p = AnchorPointPositionModifier.projectedPoint(unitPoint: .zero, frame: frame)
        #expect(p.x == 10)
        #expect(p.y == 20)
    }
    @Test func center_unitPoint_returns_center() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 60)
        let p = AnchorPointPositionModifier.projectedPoint(unitPoint: .center, frame: frame)
        #expect(abs(p.x - 50) < 0.001)
        #expect(abs(p.y - 30) < 0.001)
    }
    @Test func bottomTrailing_unitPoint_returns_maxCorner() {
        let frame = CGRect(x: 5, y: 10, width: 80, height: 40)
        let p = AnchorPointPositionModifier.projectedPoint(unitPoint: UnitPoint(x: 1, y: 1), frame: frame)
        #expect(abs(p.x - 85) < 0.001) // 5 + 80
        #expect(abs(p.y - 50) < 0.001) // 10 + 40
    }
}
