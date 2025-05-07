//
//  Created by Valeriy Malishevskyi on 22.02.2024.
//

import SwiftUI

/// A modifier that applies a custom effect to a view based on its geometry.
///
/// This struct captures the essence of a geometry-based visual effect, allowing you to encapsulate complex view transformations that depend on the view's geometric properties.
/// It's the backbone of the `geometryEffect` modifier, providing the functionality to apply the effect.
///
/// - Parameter effect: The closure that encapsulates the custom effect, taking a snapshot of the view and its geometry as inputs, and producing a transformed view.
public struct GeometryEffectView<Root: View, Content: View>: View {
    var root: Root
    var content: @MainActor (Root, GeometryEffectProxy) -> Content
    
    public init(
        root: Root,
        @ViewBuilder content: @MainActor @escaping (Root, GeometryEffectProxy) -> Content
    ) {
        self.root = root
        self.content = content
    }
    
    public var body: some View {
        root
            .hidden()
            .modifier(GeometryProxyWrapper())
            .overlayPreferenceValue(GeometryEffectProxyPreferenceKey.self) { proxy in
                content(root, proxy)
            }
    }
}

struct GeometryProxyWrapper: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: GeometryEffectProxyPreferenceKey.self,
                        value: GeometryEffectProxy(geometry)
                    )
                }
            )
    }
}

@MainActor public struct GeometryEffectProxy: Equatable, Sendable {
    private let localFrame: CGRect?
    private let globalFrame: CGRect?
    private let proxy: EquatableGeometryProxy?
    
    public let safeAreaInsets: EdgeInsets
    
    public var size: CGSize {
        localFrame?.size ?? .zero
    }
    
    static nonisolated var empty: GeometryEffectProxy {
        .init(nil)
    }
    
    public nonisolated init(_ geometry: GeometryProxy?) {
        localFrame = geometry?.frame(in: .local)
        globalFrame = geometry?.frame(in: .global)
       
        safeAreaInsets = geometry?.safeAreaInsets ?? .init()
        
        proxy = geometry.map(EquatableGeometryProxy.init)
    }
    
    public func _frame(in coordinateSpace: CoordinateSpace) -> CGRect? {
        switch coordinateSpace {
        case .local:
            guard let result = localFrame else {
                return nil
            }
            
            return result
        case .global:
            guard let result = globalFrame else {
                return nil
            }
            
            return result
        case .named(let name):
            guard let result = proxy?.proxy.frame(in: coordinateSpace) else {
                return nil
            }
            
            return result
        default:
            return nil
        }
    }

    public func frame(
        in coordinateSpace: CoordinateSpace
    ) -> CGRect {
        _frame(in: coordinateSpace) ?? .zero
    }
}

private struct EquatableGeometryProxy: Equatable, @unchecked Sendable {
    let proxy: GeometryProxy
    
    init(_ proxy: GeometryProxy) {
        self.proxy = proxy
    }
    
    static func == (lhs: EquatableGeometryProxy, rhs: EquatableGeometryProxy) -> Bool {
        true
    }
}

struct GeometryEffectProxyPreferenceKey: PreferenceKey {
    static let defaultValue: GeometryEffectProxy = .empty
    
    static func reduce(value: inout GeometryEffectProxy, nextValue: () -> GeometryEffectProxy) {
        let isChanged = value != nextValue()
        let isNotEmpty = value != .empty
        if isChanged && isNotEmpty {
            value = nextValue()
        }
        print("GeometryEffectProxyPreferenceKey reduce called with \(value)")
    }
}
