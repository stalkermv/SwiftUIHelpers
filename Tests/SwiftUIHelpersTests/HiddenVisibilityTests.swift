import Testing
@testable import SwiftUIExtensions

struct HiddenVisibilityTests {
    @Test func isHidden_remove_true_returns_removed() {
        #expect(VisibilityDecision.decision(isHidden: true, remove: true) == .removed)
    }
    @Test func isHidden_remove_false_returns_hidden() {
        #expect(VisibilityDecision.decision(isHidden: true, remove: false) == .hidden)
    }
    @Test func notHidden_remove_false_returns_visible() {
        #expect(VisibilityDecision.decision(isHidden: false, remove: false) == .visible)
    }
    @Test func notHidden_remove_true_returns_visible() {
        #expect(VisibilityDecision.decision(isHidden: false, remove: true) == .visible)
    }
}
