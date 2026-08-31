//
//  BindingTests.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 03.05.2025.
//

import SwiftUI
import Testing
@testable import SwiftUIExtensions

@MainActor struct BindingTests {
    @Test func bindingKeyPath() {
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
    
    @Test func testBindingNilCoalescingOperator() {
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

    @Test func keyPathBinding_setKnownID_updatesSelection() {
        struct Item: Identifiable, Equatable { let id: Int }
        let items = [Item(id: 1), Item(id: 2), Item(id: 3)]
        var selected: Item? = items[0]
        let selBinding = Binding<Item?>(get: { selected }, set: { selected = $0 })
        let idBinding = Binding<Int?>(selBinding, key: \.id, in: items)

        idBinding.wrappedValue = 3
        #expect(selected == items[2])
    }

    @Test func keyPathBinding_setUnknownID_isNoOp() {
        struct Item: Identifiable, Equatable { let id: Int }
        let items = [Item(id: 1), Item(id: 2)]
        var selected: Item? = items[0]
        let selBinding = Binding<Item?>(get: { selected }, set: { selected = $0 })
        let idBinding = Binding<Int?>(selBinding, key: \.id, in: items)

        idBinding.wrappedValue = 99 // unknown
        #expect(selected == items[0]) // unchanged
    }

    @Test func keyPathBinding_setNil_clearsSelection() {
        struct Item: Identifiable, Equatable { let id: Int }
        let items = [Item(id: 1), Item(id: 2)]
        var selected: Item? = items[0]
        let selBinding = Binding<Item?>(get: { selected }, set: { selected = $0 })
        let idBinding = Binding<Int?>(selBinding, key: \.id, in: items)

        idBinding.wrappedValue = nil
        #expect(selected == nil)
    }

    @Test func keyPathBinding_repeatedID_picksFirst() {
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

    // MARK: - boolean()

    @Test func boolean_getTrue_whenNonNil() {
        var value: String? = "hello"
        let b = Binding<String?>(get: { value }, set: { value = $0 })
        #expect(b.boolean().wrappedValue == true)
    }

    @Test func boolean_getFalse_whenNil() {
        var value: String? = nil
        let b = Binding<String?>(get: { value }, set: { value = $0 })
        #expect(b.boolean().wrappedValue == false)
    }

    @Test func boolean_setFalse_writesNil() {
        var value: String? = "hello"
        let b = Binding<String?>(get: { value }, set: { value = $0 })
        b.boolean().wrappedValue = false
        #expect(value == nil)
    }

    @Test func boolean_setTrue_isNoOp() {
        var value: String? = "hello"
        let b = Binding<String?>(get: { value }, set: { value = $0 })
        b.boolean().wrappedValue = true
        #expect(value == "hello") // unchanged
    }

    // MARK: - equals(_:)

    @Test func equals_getTrue_whenEqual() {
        var value: Int? = 42
        let b = Binding<Int?>(get: { value }, set: { value = $0 })
        #expect(b.equals(42).wrappedValue == true)
    }

    @Test func equals_getFalse_whenNotEqual() {
        var value: Int? = 7
        let b = Binding<Int?>(get: { value }, set: { value = $0 })
        #expect(b.equals(42).wrappedValue == false)
    }

    @Test func equals_setTrue_writesValue() {
        var value: Int? = nil
        let b = Binding<Int?>(get: { value }, set: { value = $0 })
        b.equals(42).wrappedValue = true
        #expect(value == 42)
    }

    @Test func equals_setFalseWhenEqual_writesNil() {
        var value: Int? = 42
        let b = Binding<Int?>(get: { value }, set: { value = $0 })
        b.equals(42).wrappedValue = false
        #expect(value == nil)
    }

    @Test func equals_setFalseWhenNotEqual_isNoOp() {
        var value: Int? = 7
        let b = Binding<Int?>(get: { value }, set: { value = $0 })
        b.equals(42).wrappedValue = false
        #expect(value == 7) // unchanged
    }
}
