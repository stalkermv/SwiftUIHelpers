//
//  View+defaultScrollAnchor.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 28.09.2024.
//

import SwiftUI

extension View {
    public func defaultScrollAnchor(index: Int, count: Int) -> some View {
        modifier(DefaultScrollAnchorModifier(index: index, count: count))
    }
}

struct DefaultScrollAnchorModifier: ViewModifier {
    var index: Int
    var count: Int
    
    private var defaultScrollAnchor: UnitPoint? {
        let index = CGFloat(self.index)
        let count = CGFloat(self.count)
        let offset: CGFloat = index / (count - 1)
        return .init(x: offset, y: 0.5)
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 17, macOS 14.4, tvOS 17.4, watchOS 10.4, *) {
            content.defaultScrollAnchor(defaultScrollAnchor)
        } else {
            content
        }
    }
}
