import Testing
import SwiftUI
@testable import SwiftUIHelpers

@MainActor struct SelectableArrayTests {
    struct Item: Identifiable, Equatable {
        let id: Int
    }

    @Test func init_defaultsSelectionToFirst() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)])
        #expect(a.selection?.id == 1)
    }

    @Test func init_emptyArray_selectionIsNil() {
        let a = SelectableArray<Item>([])
        #expect(a.selection == nil)
    }

    @Test func init_explicitSelection_usedWhenPresent() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)], selection: Item(id: 2))
        #expect(a.selection?.id == 2)
    }

    @Test func selectionIndex_nilWhenSelectionNotInElements() {
        // Provide a selection that has no matching ID in elements
        let a = SelectableArray([Item(id: 1), Item(id: 2)], selection: Item(id: 99))
        #expect(a.selectionIndex == nil)
    }

    @Test func selectionIndex_correctForKnownElement() {
        let a = SelectableArray([Item(id: 1), Item(id: 2), Item(id: 3)])
        // default selection = first = index 0
        #expect(a.selectionIndex == 0)
    }

    @Test func init_outOfRangeSelectionIndex_givesNilSelection() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)], selectionIndex: 99)
        #expect(a.selection == nil)
    }

    @Test func pageMetadata_format() {
        // selectionIndex for Item(id:2) in [1,2,3,4,5] is 1 → "2 / 5"
        let a = SelectableArray([Item(id: 1), Item(id: 2), Item(id: 3), Item(id: 4), Item(id: 5)],
                                selection: Item(id: 2))
        let text = SelectableArrayPageMetadata.FormatStyle().format(a.pageMetadata)
        #expect(text == "2 / 5")
    }

    @Test func isSameSelection_true_whenSameIndex() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)])
        let b = SelectableArray([Item(id: 1), Item(id: 2)])
        #expect(a.isSameSelection(as: b))
    }

    @Test func isSameSelection_false_differentSelection() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)])
        let b = SelectableArray([Item(id: 1), Item(id: 2)], selection: Item(id: 2))
        #expect(!a.isSameSelection(as: b))
    }

    @Test func equality_ignoresSelection() {
        let a = SelectableArray([Item(id: 1), Item(id: 2)])
        let b = SelectableArray([Item(id: 1), Item(id: 2)], selection: Item(id: 2))
        // == compares elements only, not selection
        #expect(a == b)
    }
}
