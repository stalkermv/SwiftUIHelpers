import Testing
@testable import SwiftUIHelpers

// Argument tables live at file scope: `@Test(arguments:)` cannot reference
// actor-isolated statics, and these rows must be plain Sendable values.
private let multiplierCases: [(level: HierarchicalPaletteLevel, expected: Double)] = [
    (.primary, 1.0),
    (.secondary, 255.0 / 128.0),
    (.tertiary, 255.0 / 64.0),
    (.quaternary, 255.0 / 46.0),
    (.quinary, 255.0 / 46.0),
]

private let rawLevelKnownCases: [(raw: Int, expected: HierarchicalPaletteLevel)] = [
    (0, .primary),
    (1, .secondary),
    (4, .quinary),
]

private let rawLevelUnknownCases: [Int] = [99, -1]

private let classifyOperationCases: [(raw: String, expectedKind: HierarchicalPaletteOperationKind)] = [
    ("resolveStyle(levels: 0..<1)", .resolveStyle),
    ("prepareText(level: 2, something)", .prepareText),
    ("copyStyle(name: foreground, color: red)", .copyStyleForeground),
    ("copyStyle(name: background, color: red)", .copyStyleOther),
    ("primaryStyle", .primaryStyle),
    ("somethingUnknown", .unknown),
]

private let parseLevelCases: [(token: String, raw: String, expected: Int?)] = [
    ("level: ", "prepareText(level: 2, x)", 2),
    ("level: ", "primaryStyle", nil),
]

@Suite("Hierarchical palette", .tags(.palette))
struct PaletteTests {
    // MARK: - HierarchicalPaletteCompensation.multiplier(for:)
    @Test("Multiplier compensates each hierarchy level", arguments: multiplierCases)
    func multiplier(level: HierarchicalPaletteLevel, expected: Double) {
        let compensation = HierarchicalPaletteCompensation.default
        #expect(abs(compensation.multiplier(for: level) - expected) < 0.0001)
    }

    // MARK: - HierarchicalPaletteLevel(rawLevel:) fallback
    @Test("A known raw level maps to its case", arguments: rawLevelKnownCases)
    func rawLevelKnown(raw: Int, expected: HierarchicalPaletteLevel) {
        #expect(HierarchicalPaletteLevel(rawLevel: raw) == expected)
    }

    @Test("An unknown raw level falls back to primary", arguments: rawLevelUnknownCases)
    func rawLevelUnknownFallsBackToPrimary(raw: Int) {
        #expect(HierarchicalPaletteLevel(rawLevel: raw) == .primary)
    }

    // MARK: - classifyOperation
    @Test("classifyOperation recognizes each raw operation string", arguments: classifyOperationCases)
    func classifyOperation(raw: String, expectedKind: HierarchicalPaletteOperationKind) {
        #expect(HierarchicalPaletteIntrospection.classifyOperation(raw: raw) == expectedKind)
    }

    // MARK: - parseLevel
    @Test("parseLevel extracts the trailing number after a token, or nil if absent", arguments: parseLevelCases)
    func parseLevel(token: String, raw: String, expected: Int?) {
        #expect(HierarchicalPaletteIntrospection.parseLevel(after: token, in: raw) == expected)
    }
}
