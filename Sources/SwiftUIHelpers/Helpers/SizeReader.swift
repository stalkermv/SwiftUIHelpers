//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import SwiftUI

fileprivate struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

public extension View {
    /// Adds a hidden view with a `GeometryReader` to read the size of the view, then calls the specified closure with the size whenever it changes.
    ///
    /// - Parameter onChange: A closure called with the size of the view whenever it changes.
    ///
    /// - Returns: A view with a hidden `GeometryReader`.
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        overlay(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

public extension View {
    /// Adds a hidden view with a `GeometryReader` to read the width of the view, then sets the specified binding to the width
    /// whenever it changes.
    ///
    /// - Parameter width: A binding to the width of the view.
    ///
    /// - Returns: A view with a hidden `GeometryReader`.
    func readFrameWidth(_ width: Binding<CGFloat>) -> some View {
        readSize { newSize in
            width.wrappedValue = newSize.width
        }
    }
    
    /// Adds a hidden view with a `GeometryReader` to read the height of the view, then sets the specified binding to the height
    /// whenever it changes.
    ///
    /// - Parameter height: A binding to the height of the view.
    ///
    /// - Returns: A view with a hidden `GeometryReader`.
    func readFrameHeight(_ height: Binding<CGFloat>) -> some View {
        readSize { newSize in
            height.wrappedValue = newSize.height
        }
    }
}

