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
}
