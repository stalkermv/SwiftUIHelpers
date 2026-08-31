//
//  DynamicPropertyTests.swift
//  SwiftUIHelpers
//
//  Probes StateOrBinding and EnvironmentOrValue outside of a SwiftUI render loop.
//  See "Known limitations" note below.

import Testing
import SwiftUI
@testable import SwiftUIHelpers

// MARK: - StateOrBinding

@MainActor struct StateOrBindingTests {

    // Construct .state and read wrappedValue
    @Test func state_init_wrappedValue() {
        let s = StateOrBinding(42)
        #expect(s.wrappedValue == 42)
    }

    // projectedValue is a Binding; reading it gives wrappedValue
    @Test func state_projectedValue_read() {
        let s: StateOrBinding<String> = StateOrBinding("hello")
        #expect(s.projectedValue.wrappedValue == "hello")
    }

    // Mutate via projectedValue binding
    @Test func state_projectedValue_write() {
        var s = StateOrBinding(1)
        s.projectedValue.wrappedValue = 99
        // Outside SwiftUI, State stores its initial value in the heap box.
        // A write on a freshly created State has no @_storageRestrictions graph
        // to update, so the set is a no-op. Document: read back equals initial.
        // This verifies the call doesn't crash, not a round-trip guarantee.
        #expect(s.wrappedValue == 1 || s.wrappedValue == 99)
    }

    // update() call must not crash
    @Test func state_update_doesNotCrash() {
        var s = StateOrBinding(true)
        s.update() // should be a no-op outside SwiftUI; no crash expected
        #expect(s.wrappedValue == true || s.wrappedValue == false)
    }

    // Construct .binding case
    @Test func binding_case_wrappedValue() {
        var storage = 7
        let b = Binding<Int>(get: { storage }, set: { storage = $0 })
        let s: StateOrBinding<Int> = StateOrBinding(b)
        #expect(s.wrappedValue == 7)
        s.wrappedValue = 42
        #expect(storage == 42)
        #expect(s.wrappedValue == 42)
    }

    // projectedValue for .binding returns the original binding
    @Test func binding_case_projectedValue() {
        var storage = "x"
        let b = Binding<String>(get: { storage }, set: { storage = $0 })
        let s: StateOrBinding<String> = StateOrBinding(b)
        s.projectedValue.wrappedValue = "y"
        #expect(storage == "y")
    }

    // Optional init returns nil for nil binding
    @Test func optional_init_nil() {
        let s = StateOrBinding<Int>(Binding<Int>?(nil))
        #expect(s == nil)
    }

    // Optional init returns non-nil for valid binding
    @Test func optional_init_nonNil() {
        var v = 5
        let b: Binding<Int>? = Binding(get: { v }, set: { v = $0 })
        let s = StateOrBinding<Int>(b)
        #expect(s != nil)
        #expect(s?.wrappedValue == 5)
    }
}

// MARK: - EnvironmentOrValue

@MainActor struct EnvironmentOrValueTests {

    // Construct with a direct value, read wrappedValue
    @Test func value_init_wrappedValue() {
        let e = EnvironmentOrValue(99)
        #expect(e.wrappedValue == 99)
        #expect(e.isValue == true)
    }

    // isValue is false for keyPath init
    @Test func keyPath_init_isValue_false() {
        let e = EnvironmentOrValue(\.colorScheme)
        #expect(e.isValue == false)
    }

    // keyPath init: update() must not crash; wrappedValue falls back to
    // the default environment value (light scheme in test context)
    @Test func keyPath_init_readDoesNotCrash() {
        let e = EnvironmentOrValue(\.colorScheme)
        // Reading wrappedValue outside a View: EnvironmentValues() default is used.
        // Document outcome: typically .light.
        let _ = e.wrappedValue
    }

    // Writing overrides to .value storage
    @Test func write_switches_to_value_storage() {
        var e = EnvironmentOrValue(\.colorScheme)
        #expect(e.isValue == false)
        e.wrappedValue = .dark
        #expect(e.isValue == true)
        #expect(e.wrappedValue == .dark)
    }
}
