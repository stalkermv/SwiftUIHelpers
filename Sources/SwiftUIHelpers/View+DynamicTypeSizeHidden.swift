//
//  View+DynamicTypeSizeHidden.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 10.04.2025.
//

#if canImport(UIKit)
import SwiftUI

extension View {
    public func hidden<T>(for dynamicTypeSizeRange: T) -> some View
    where T : RangeExpression, T.Bound == DynamicTypeSize {
        let modifier = DynamicTypeSizeHiddenModifier(categories: dynamicTypeSizeRange)
        return self.modifier(modifier)
    }
}

struct DynamicTypeSizeHiddenModifier: ViewModifier {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let categories: any RangeExpression<DynamicTypeSize>
    
    func body(content: Content) -> some View {
        content
            .hidden(categories.contains(dynamicTypeSize), remove: true)
    }
}
#endif
