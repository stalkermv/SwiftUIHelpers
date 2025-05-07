//
//  StatefulContainer.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 31.07.2024.
//

import SwiftUI

public struct StatefulContainer<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    public var body: some View {
        content($value)
    }
    
    public init(_ value: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
    
    public init(_ value: () -> Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value())
        self.content = content
    }
}
