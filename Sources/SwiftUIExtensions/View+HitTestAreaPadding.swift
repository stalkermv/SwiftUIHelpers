//
//  View+HitTestAreaPadding.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 01.08.2024.
//

import SwiftUI

public enum PaddingAreaScope {
    case hitTestArea
}

extension View {
    public func padding(_ insets: EdgeInsets, for scope: PaddingAreaScope) -> some View {
        modifier(HitTestAreaPaddingModifier(insets: insets))
    }
    
    public func padding(_ edges: Edge.Set = .all, _ length: CGFloat, for scope: PaddingAreaScope) -> some View {
        let edgeInsets = EdgeInsets(
            top: edges.contains(.top) ? length : 0,
            leading: edges.contains(.leading) ? length : 0,
            bottom: edges.contains(.bottom) ? length : 0,
            trailing: edges.contains(.trailing) ? length : 0
        )
        
        return padding(edgeInsets, for: .hitTestArea)
    }
    
    public func padding(_ length: CGFloat, for scope: PaddingAreaScope) -> some View {
        padding(.all, length, for: .hitTestArea)
    }
}

private struct HitTestAreaPaddingModifier: ViewModifier {
    let insets: EdgeInsets
    
    func body(content: Content) -> some View {
        content
            .padding(insets)
            .contentShape(.rect)
            .padding(-insets)
    }
}

