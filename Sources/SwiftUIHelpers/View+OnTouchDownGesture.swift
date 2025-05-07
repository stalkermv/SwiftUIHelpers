//
//  View+OnTouchDownGesture.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 02.08.2024.
//

import SwiftUI

extension View {
    public func onTouchDownGesture(callback: @escaping (Bool) -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(callback: callback))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let callback: (Bool) -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.tapped {
                        self.tapped = true
                        self.callback(true)
                    }
                }
                .onEnded { _ in
                    if self.tapped {
                        self.callback(false)
                        self.tapped = false
                    }
                })
    }
}
