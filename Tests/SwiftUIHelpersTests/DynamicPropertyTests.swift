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

@MainActor @Suite("State or binding", .tags(.dynamicProperties))
struct StateOrBindingTests {

    @Test("Constructing from a value reads back through wrappedValue")
    func stateInitWrappedValue() {
        let s = StateOrBinding(42)
        #expect(s.wrappedValue == 42)
    }

    @Test("projectedValue is a binding that reflects the current wrappedValue")
    func stateProjectedValueRead() {
        let s: StateOrBinding<String> = StateOrBinding("hello")
        #expect(s.projectedValue.wrappedValue == "hello")
    }

    @Test("Writing through projectedValue outside the render loop does not round-trip")
    func stateProjectedValueWrite() {
        var s = StateOrBinding(1)
        s.projectedValue.wrappedValue = 99
        // Outside the render loop State has no storage node; reads return the
        // initial value — this is a deliberate implementation-regression check
        // (see README Known limitations).
        #expect(s.wrappedValue == 1)
    }

    @Test("Calling update() outside the render loop leaves the value unchanged")
    func stateUpdateDoesNotCrash() {
        var s = StateOrBinding(true)
        s.update()
        // Outside the render loop State has no storage node; reads return the
        // initial value — this is a deliberate implementation-regression check
        // (see README Known limitations).
        #expect(s.wrappedValue == true)
    }

    @Test("The binding case reads and writes through the underlying binding")
    func bindingCaseWrappedValue() {
        var storage = 7
        let b = Binding<Int>(get: { storage }, set: { storage = $0 })
        let s: StateOrBinding<Int> = StateOrBinding(b)
        #expect(s.wrappedValue == 7)
        s.wrappedValue = 42
        #expect(storage == 42)
        #expect(s.wrappedValue == 42)
    }

    @Test("projectedValue for the binding case returns the original binding")
    func bindingCaseProjectedValue() {
        var storage = "x"
        let b = Binding<String>(get: { storage }, set: { storage = $0 })
        let s: StateOrBinding<String> = StateOrBinding(b)
        s.projectedValue.wrappedValue = "y"
        #expect(storage == "y")
    }

    @Test("The optional initializer returns nil for a nil binding")
    func optionalInitNil() {
        let s = StateOrBinding<Int>(Binding<Int>?(nil))
        #expect(s == nil)
    }

    @Test("The optional initializer returns a value for a valid binding")
    func optionalInitNonNil() {
        var v = 5
        let b: Binding<Int>? = Binding(get: { v }, set: { v = $0 })
        let s = StateOrBinding<Int>(b)
        #expect(s != nil)
        #expect(s?.wrappedValue == 5)
    }
}

// MARK: - EnvironmentOrValue

@MainActor @Suite("Environment or value", .tags(.dynamicProperties))
struct EnvironmentOrValueTests {

    @Test("Constructing from a direct value reports isValue and reads it back")
    func valueInitWrappedValue() {
        let e = EnvironmentOrValue(99)
        #expect(e.wrappedValue == 99)
        #expect(e.isValue == true)
    }

    @Test("Constructing from a key path reports isValue false")
    func keyPathInitIsValueFalse() {
        let e = EnvironmentOrValue(\.colorScheme)
        #expect(e.isValue == false)
    }

    @Test("Reading a key-path-backed value outside a view falls back to the platform default")
    func keyPathInitReadUsesPlatformDefault() {
        let e = EnvironmentOrValue(\.colorScheme)
        // Reading wrappedValue outside a View constructs a fresh
        // EnvironmentValues(), whose colorScheme default is .light in test
        // context (see README Known limitations).
        #expect(e.wrappedValue == .light)
    }

    @Test("Writing switches storage from environment-backed to value-backed")
    func writeSwitchesToValueStorage() {
        var e = EnvironmentOrValue(\.colorScheme)
        #expect(e.isValue == false)
        e.wrappedValue = .dark
        #expect(e.isValue == true)
        #expect(e.wrappedValue == .dark)
    }
}
