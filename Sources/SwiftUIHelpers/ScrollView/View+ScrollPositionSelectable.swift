//
//  View+ScrollPositionSelectable.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 28.09.2024.
//

import SwiftUI
import SwiftUIExtensions

extension View {
    public func scrollPosition<Element>(selectable array: SelectableArray<Element>) -> some View where Element: Identifiable {
        modifier(
            ScrollPositionModifier(
                selectable: array,
                selection: array.$selection)
        )
    }
}

struct ScrollPositionModifier<Element: Identifiable>: ViewModifier {
    var selectable: SelectableArray<Element>
    @Binding var selection: Element?
    
    @MainActor private var defaultScrollAnchor: UnitPoint? {
        let index = CGFloat(selectable.pageMetadata.index)
        let count = CGFloat(selectable.pageMetadata.count)
        guard count > 1 else { return nil }
        
        let offset: CGFloat = index / (count - 1)
        return .init(x: offset, y: 0.5)
    }
    
    init(selectable: SelectableArray<Element>, selection: Binding<Element?>) {
        self.selectable = selectable
        self._selection = selection
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 17, macOS 14.4, tvOS 17.4, watchOS 10.4, *) {
            content
                .defaultScrollAnchor(defaultScrollAnchor)
                .scrollPosition(id: Binding($selection, key: \.id, in: selectable))
        } else {
            content
        }
    }
}
