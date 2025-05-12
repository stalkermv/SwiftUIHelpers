//
//  SelectableArray.swift
//  SwiftHelpers
//
//  Created by Valeriy Malishevskyi on 28.09.2024.
//

import SwiftUI

/// A collection that stores elements and allows for a single element to be selected.
///
/// `SelectableArray` is a custom data structure that behaves like a standard array with additional functionality
/// to manage a selection state. It conforms to `RandomAccessCollection`, `MutableCollection`, and `BidirectionalCollection`,
/// which allows it to be used similarly to an array. Additionally, it conforms to `ExpressibleByArrayLiteral` and
/// `DynamicProperty`, making it suitable for use in SwiftUI environments.
///
/// The selection is managed as a state using SwiftUI's `@State` property wrapper, enabling the `SelectableArray` to be
/// used within SwiftUI views and have its state managed automatically by the SwiftUI framework.
public struct SelectableArray<Element>: RandomAccessCollection, MutableCollection, ExpressibleByArrayLiteral, BidirectionalCollection, DynamicProperty {
    
    /// The current selected element in the array, if any.
    @State @MainActor public var selection: Element?
    
    public var startIndex: Int { elements.startIndex }
    public var endIndex: Int { elements.endIndex }
    
    public subscript(position: Int) -> Element {
        get { elements[position] }
        set { elements[position] = newValue }
    }
    
    /// Creates an instance initialized with the given elements.
    ///
    /// - Parameter elements: A variadic list of elements to initialize the collection.
    public init(arrayLiteral elements: Element...) {
        self.elements = elements
        _selection = State(initialValue: elements.first)
    }
    
    /// Creates an instance initialized with the given array of elements.
    ///
    /// - Parameter elements: An array of elements to initialize the collection.
    public init(_ elements: [Element], selection: Element? = nil) {
        self.elements = elements
        _selection = State(initialValue: selection ?? elements.first)
    }
    
    public init(_ elements: [Element], selectionIndex: Int?) {
        self.elements = elements
        
        _selection = State(initialValue: selectionIndex.flatMap { elements[safe: $0] })
    }
    
    /// The underlying array of elements in the collection.
    public var elements: [Element]
}

extension SelectableArray where Element : Identifiable {
    @MainActor public var selectionIndex: Int? {
        elements.firstIndex { $0.id == selection?.id }
    }
    
    @MainActor public var selectionIndexBinding: Binding<Element?> {
        .init(get: { selection }, set: { selection = $0 })
    }
    
    public init(_ elements: [Element], selection: Element.ID) {
        self.elements = elements
        _selection = State(initialValue: elements.first { $0.id == selection })
    }
}

extension SelectableArray: Equatable where Element: Equatable {
    public static func == (lhs: SelectableArray<Element>, rhs: SelectableArray<Element>) -> Bool {
        lhs.elements == rhs.elements
    }
}

extension SelectableArray {
    public var collection: [Element] { elements }
}

private extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
