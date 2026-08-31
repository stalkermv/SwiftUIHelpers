import Testing
@testable import SwiftUIHelpers

struct DetentGeometryTests {
    @Test func normalUpdate_heightPlusInset() {
        let r = FitPresentationDetentModifier.resolvedDetentHeight(
            frameHeight: 400, safeAreaTop: 44, trackedSafeAreaTop: 44)
        #expect(r.height == 444)
        #expect(r.safeAreaTop == 44)
    }

    @Test func bigDelta_resets_tracking() {
        // abs(50 - 44) = 6 < 16 → no reset
        let noReset = FitPresentationDetentModifier.resolvedDetentHeight(
            frameHeight: 400, safeAreaTop: 50, trackedSafeAreaTop: 44)
        #expect(noReset.safeAreaTop == 44)

        // abs(0 - 44) = 44 > 16 → reset
        let reset = FitPresentationDetentModifier.resolvedDetentHeight(
            frameHeight: 400, safeAreaTop: 0, trackedSafeAreaTop: 44)
        #expect(reset.safeAreaTop == 0)
    }

    @Test func trackedNonZero_newZero_resets() {
        let r = FitPresentationDetentModifier.resolvedDetentHeight(
            frameHeight: 300, safeAreaTop: 0, trackedSafeAreaTop: 5)
        // tracked=5≠0, new=0 → reset
        #expect(r.safeAreaTop == 0)
    }

    @Test func trackedZero_newZero_noReset() {
        let r = FitPresentationDetentModifier.resolvedDetentHeight(
            frameHeight: 300, safeAreaTop: 0, trackedSafeAreaTop: 0)
        // delta=0, tracked==0 so second condition is false → no reset
        #expect(r.safeAreaTop == 0)
    }

    @Test func heightPassThrough() {
        let r = FitPresentationDetentModifier.resolvedDetentHeight(
            frameHeight: 500, safeAreaTop: 20, trackedSafeAreaTop: 20)
        #expect(r.height == 520)
    }
}
