import Testing
@testable import SwiftUIExtensions

// Argument table lives at file scope: `@Test(arguments:)` cannot reference
// actor-isolated statics, and these rows must be plain Sendable values.
private let visibilityDecisionCases: [(isHidden: Bool, remove: Bool, expected: VisibilityDecision)] = [
    (true, true, .removed),
    (true, false, .hidden),
    (false, false, .visible),
    (false, true, .visible),
]

@Suite("Hidden modifier", .tags(.visibility))
struct HiddenVisibilityTests {
    @Test("Decision resolves from the isHidden and remove flags", arguments: visibilityDecisionCases)
    func decision(isHidden: Bool, remove: Bool, expected: VisibilityDecision) {
        #expect(VisibilityDecision.decision(isHidden: isHidden, remove: remove) == expected)
    }
}
