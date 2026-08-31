import Testing
@testable import SwiftUIHelpers

struct PaletteTests {
    // MARK: - HierarchicalPaletteCompensation.multiplier(for:)
    @Test func multiplier_primary_is_1() {
        let c = HierarchicalPaletteCompensation.default
        #expect(c.multiplier(for: .primary) == 1.0)
    }
    @Test func multiplier_secondary() {
        let c = HierarchicalPaletteCompensation.default
        #expect(abs(c.multiplier(for: .secondary) - 255.0/128.0) < 0.0001)
    }
    @Test func multiplier_tertiary() {
        let c = HierarchicalPaletteCompensation.default
        #expect(abs(c.multiplier(for: .tertiary) - 255.0/64.0) < 0.0001)
    }
    @Test func multiplier_quaternary() {
        let c = HierarchicalPaletteCompensation.default
        #expect(abs(c.multiplier(for: .quaternary) - 255.0/46.0) < 0.0001)
    }
    @Test func multiplier_quinary() {
        let c = HierarchicalPaletteCompensation.default
        #expect(abs(c.multiplier(for: .quinary) - 255.0/46.0) < 0.0001)
    }

    // MARK: - HierarchicalPaletteLevel(rawLevel:) fallback
    @Test func rawLevel_known_values() {
        #expect(HierarchicalPaletteLevel(rawLevel: 0) == .primary)
        #expect(HierarchicalPaletteLevel(rawLevel: 1) == .secondary)
        #expect(HierarchicalPaletteLevel(rawLevel: 4) == .quinary)
    }
    @Test func rawLevel_unknown_fallback_to_primary() {
        #expect(HierarchicalPaletteLevel(rawLevel: 99) == .primary)
        #expect(HierarchicalPaletteLevel(rawLevel: -1) == .primary)
    }

    // MARK: - classifyOperation
    @Test func classifyOperation_resolveStyle() {
        let raw = "resolveStyle(levels: 0..<1)"
        #expect(HierarchicalPaletteIntrospection.classifyOperation(raw: raw) == .resolveStyle)
    }
    @Test func classifyOperation_prepareText() {
        let raw = "prepareText(level: 2, something)"
        #expect(HierarchicalPaletteIntrospection.classifyOperation(raw: raw) == .prepareText)
    }
    @Test func classifyOperation_copyStyleForeground() {
        let raw = "copyStyle(name: foreground, color: red)"
        #expect(HierarchicalPaletteIntrospection.classifyOperation(raw: raw) == .copyStyleForeground)
    }
    @Test func classifyOperation_copyStyleOther() {
        let raw = "copyStyle(name: background, color: red)"
        #expect(HierarchicalPaletteIntrospection.classifyOperation(raw: raw) == .copyStyleOther)
    }
    @Test func classifyOperation_primaryStyle() {
        #expect(HierarchicalPaletteIntrospection.classifyOperation(raw: "primaryStyle") == .primaryStyle)
    }
    @Test func classifyOperation_unknown() {
        #expect(HierarchicalPaletteIntrospection.classifyOperation(raw: "somethingUnknown") == .unknown)
    }

    // MARK: - parseLevel
    @Test func parseLevel_extractsNumber() {
        #expect(HierarchicalPaletteIntrospection.parseLevel(after: "level: ", in: "prepareText(level: 2, x)") == 2)
    }
    @Test func parseLevel_missingToken_returnsNil() {
        #expect(HierarchicalPaletteIntrospection.parseLevel(after: "level: ", in: "primaryStyle") == nil)
    }
}
