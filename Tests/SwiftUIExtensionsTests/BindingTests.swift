//
//  BindingTests.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 03.05.2025.
//

import SwiftUI
import Testing
@testable import SwiftUIExtensions

// Argument tables live at file scope: `@Test(arguments:)` cannot reference
// actor-isolated statics, and these rows must be plain Sendable values.
private let booleanGetCases: [(value: String?, expected: Bool)] = [
    (nil, false),
    ("hello", true),
]

private let equalsGetCases: [(storedValue: Int?, expected: Bool)] = [
    (nil, false),
    (7, false),
    (42, true),
]

@MainActor @Suite("Binding helpers", .tags(.bindings))
struct BindingTests {
    @Test("Key-path binding reads and writes selection by ID") func bindingKeyPath() {
        struct Item: Identifiable, Equatable {
            let id: Int
            let name: String
        }
        
        let items = [
            Item(id: 1, name: "One"),
            Item(id: 2, name: "Two"),
            Item(id: 3, name: "Three")
        ]
        
        var selected: Item? = items[0]
        let selectedBinding = Binding<Item?>(
            get: { selected },
            set: { selected = $0 }
        )
        
        let idBinding = Binding<Int?>(
            selectedBinding,
            key: \.id,
            in: items
        )
        #expect(idBinding.wrappedValue == 1)

        idBinding.wrappedValue = 2
        #expect(selected == items[1])

        selected = nil
        #expect(idBinding.wrappedValue == nil)
    }
    
    @Test("Nil-coalescing binding falls back to default and writes through")
    func bindingNilCoalescingOperator() {
        var value: Int? = nil
        let optionalBinding = Binding<Int?>(
            get: { value },
            set: { value = $0 }
        )
        let nonOptionalBinding = optionalBinding ?? 42

        // Should return the default value when nil
        #expect(nonOptionalBinding.wrappedValue == 42)

        // Setting the non-optional binding updates the original value
        nonOptionalBinding.wrappedValue = 100
        #expect(value == 100)
        #expect(nonOptionalBinding.wrappedValue == 100)

        // Setting the original value to nil again
        value = nil
        #expect(nonOptionalBinding.wrappedValue == 42)
    }

    // MARK: - Key-path binding matrix

    @Test("Setting a known ID updates the selection")
    func keyPathBindingSetKnownID() {
        struct Item: Identifiable, Equatable { let id: Int }
        let items = [Item(id: 1), Item(id: 2), Item(id: 3)]
        var selected: Item? = items[0]
        let selBinding = Binding<Item?>(get: { selected }, set: { selected = $0 })
        let idBinding = Binding<Int?>(selBinding, key: \.id, in: items)

        idBinding.wrappedValue = 3
        #expect(selected == items[2])
    }

    @Test("Setting an unknown ID leaves the selection unchanged")
    func keyPathBindingSetUnknownID() {
        struct Item: Identifiable, Equatable { let id: Int }
        let items = [Item(id: 1), Item(id: 2)]
        var selected: Item? = items[0]
        let selBinding = Binding<Item?>(get: { selected }, set: { selected = $0 })
        let idBinding = Binding<Int?>(selBinding, key: \.id, in: items)

        idBinding.wrappedValue = 99 // unknown
        #expect(selected == items[0]) // unchanged
    }

    @Test("Setting nil clears the selection")
    func keyPathBindingSetNil() {
        struct Item: Identifiable, Equatable { let id: Int }
        let items = [Item(id: 1), Item(id: 2)]
        var selected: Item? = items[0]
        let selBinding = Binding<Item?>(get: { selected }, set: { selected = $0 })
        let idBinding = Binding<Int?>(selBinding, key: \.id, in: items)

        idBinding.wrappedValue = nil
        #expect(selected == nil)
    }

    @Test("A repeated ID matches the first element")
    func keyPathBindingRepeatedID() {
        struct Item: Identifiable, Equatable {
            let id: Int
            let tag: String
        }
        // Two items share id=1; the binding should match the first one
        let items = [Item(id: 1, tag: "first"), Item(id: 1, tag: "second"), Item(id: 2, tag: "other")]
        var selected: Item? = items[2]
        let selBinding = Binding<Item?>(get: { selected }, set: { selected = $0 })
        let idBinding = Binding<Int?>(selBinding, key: \.id, in: items)

        idBinding.wrappedValue = 1
        #expect(selected?.tag == "first")
    }

        // MARK: - boolean() — get cases (parameterized)

    @Test("Boolean get reflects nil-ness of wrapped value", arguments: booleanGetCases)
    func booleanGet(value: String?, expected: Bool) {
        let box = ValueBox<String?>(value)
        #expect(box.binding.boolean().wrappedValue == expected)
    }

    // MARK: - boolean() — mutation tests

    @Test("Setting boolean to false writes nil")
    func booleanSetFalseWritesNil() {
        let box = ValueBox<String?>("hello")
        box.binding.boolean().wrappedValue = false
        #expect(box.value == nil)
    }

    @Test("Setting boolean to true leaves existing value unchanged")
    func booleanSetTrueIsNoOp() {
        let box = ValueBox<String?>("hello")
        box.binding.boolean().wrappedValue = true
        #expect(box.value == "hello")
    }

    // MARK: - equals(_:) — get cases (parameterized)

    @Test("Equals get reflects value equality", arguments: equalsGetCases)
    func equalsGet(storedValue: Int?, expected: Bool) {
        let box = ValueBox<Int?>(storedValue)
        #expect(box.binding.equals(42).wrappedValue == expected)
    }

    // MARK: - equals(_:) — mutation tests

    @Test("Setting equals to true writes the target value")
    func equalsSetTrueWritesValue() {
        let box = ValueBox<Int?>(nil)
        box.binding.equals(42).wrappedValue = true
        #expect(box.value == 42)
    }

    @Test("Setting equals to false when currently equal writes nil")
    func equalsSetFalseWhenEqualWritesNil() {
        let box = ValueBox<Int?>(42)
        box.binding.equals(42).wrappedValue = false
        #expect(box.value == nil)
    }

    @Test("Setting equals to false when not equal is a no-op")
    func equalsSetFalseWhenNotEqualIsNoOp() {
        let box = ValueBox<Int?>(7)
        box.binding.equals(42).wrappedValue = false
        #expect(box.value == 7)
    }
}
