import Testing
import SwiftUI
@testable import SwiftUIHelpers

// File scope, not `private` inside the suite: `@Test(arguments:)` cannot
// reference actor-isolated statics, and these rows must be plain Sendable
// values.
private struct Item: Identifiable, Equatable, Sendable {
    let id: Int
}

private let selectionByInitCases: [(elements: [Item], selection: Item?, expectedSelectionID: Int?)] = [
    ([Item(id: 1), Item(id: 2)], nil, 1), // no explicit selection → defaults to first
    ([], nil, nil), // empty array → no selection
    ([Item(id: 1), Item(id: 2)], Item(id: 2), 2), // explicit selection is used as-is
]

private let selectionIndexCases: [(elements: [Item], selection: Item?, expectedSelectionIndex: Int?)] = [
    ([Item(id: 1), Item(id: 2)], Item(id: 99), nil), // selection has no matching ID in elements
    ([Item(id: 1), Item(id: 2), Item(id: 3)], nil, 0), // default selection = first = index 0
]

@MainActor @Suite("Selectable array", .tags(.selection))
struct SelectableArrayTests {
    @Test("Constructing with a selection resolves the expected selection ID", arguments: selectionByInitCases)
    fileprivate func initSelection(elements: [Item], selection: Item?, expectedSelectionID: Int?) {
        let a = SelectableArray(elements, selection: selection)
        #expect(a.selection?.id == expectedSelectionID)
    }

    @Test("selectionIndex resolves against the stored selection", arguments: selectionIndexCases)
    fileprivate func selectionIndexResolution(elements: [Item], selection: Item?, expectedSelectionIndex: Int?) {
        let a = SelectableArray(elements, selection: selection)
        #expect(a.selectionIndex == expectedSelectionIndex)
    }

    @Test("An out-of-range selection index yields a nil selection")
    func initOutOfRangeSelectionIndexGivesNilSelection() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)], selectionIndex: 99)
        #expect(a.selection == nil)
    }

    @Test("Page metadata formats as \"index / count\"")
    func pageMetadataFormat() {
        // selectionIndex for Item(id: 2) in [1,2,3,4,5] is 1 → "2 / 5"
        let a = SelectableArray(
            [Item(id: 1), Item(id: 2), Item(id: 3), Item(id: 4), Item(id: 5)],
            selection: Item(id: 2)
        )
        let text = SelectableArrayPageMetadata.FormatStyle().format(a.pageMetadata)
        #expect(text == "2 / 5")
    }

    @Test("Matching selection index and elements report the same selection")
    func isSameSelectionTrueWhenSameIndex() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)])
        let b = SelectableArray([Item(id: 1), Item(id: 2)])
        #expect(a.isSameSelection(as: b))
    }

    @Test("A different selection reports as not the same selection")
    func isSameSelectionFalseWhenDifferentSelection() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)])
        let b = SelectableArray([Item(id: 1), Item(id: 2)], selection: Item(id: 2))
        #expect(a.isSameSelection(as: b) == false)
    }

    @Test("Equality compares elements only, ignoring selection")
    func equalityIgnoresSelection() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)])
        let b = SelectableArray([Item(id: 1), Item(id: 2)], selection: Item(id: 2))
        #expect(a == b)
    }
}
