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
                if let proxy {
                    content(root, proxy)
                }
            }
    }
}

struct GeometryProxyWrapper: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { geometry in
                Color.clear.preference(
                    key: GeometryEffectProxyPreferenceKey.self,
                    value: GeometryEffectProxy(geometry)
                )
            }
        }
    }
}

@MainActor public struct GeometryEffectProxy: Equatable, Sendable {
    private let localFrame: CGRect?
    private let globalFrame: CGRect?
    private let proxy: EquatableGeometryProxy?
    
    public let safeAreaInsets: EdgeInsets
    
    public var size: CGSize {
        proxy?.proxy.size ?? .zero
    }
    
    public nonisolated init(_ geometry: GeometryProxy) {
        localFrame = geometry.frame(in: .local)
        globalFrame = geometry.frame(in: .global)
       
        safeAreaInsets = geometry.safeAreaInsets
                proxy = EquatableGeometryProxy(geometry)
    }
    
    public func _frame(in coordinateSpace: CoordinateSpace) -> CGRect? {
        switch coordinateSpace {
        case .local:
            return proxy?.proxy.frame(in: .local) ?? localFrame
        case .global:
                return proxy?.proxy.frame(in: .global) ?? globalFrame
        case .named(_):
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
    static let defaultValue: GeometryEffectProxy? = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        let next = nextValue()
        let isChanged = value != next
        if isChanged {
            value = next
        }
    }
}
