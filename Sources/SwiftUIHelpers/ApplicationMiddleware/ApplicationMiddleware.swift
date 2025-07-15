//
//  ApplicationMiddleware.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 17.06.2025.
//

import SwiftUI

extension View {
    public func middleware<M: ApplicationMiddleware>(_ middleware: M) -> some View {
        modifier(middleware)
    }
    
    public func middleware<M: ViewModifier>(@ApplicationMiddlewareBuilder _ middleware: () -> M) -> some View {
        modifier(middleware())
    }
}

public protocol ApplicationMiddleware: ViewModifier {
    associatedtype MiddlewareBody: View
    @ViewBuilder func middleware(content: Content) -> Self.MiddlewareBody
}

extension ApplicationMiddleware {
    public func body(content: Content) -> Self.MiddlewareBody {
        middleware(content: content)
    }
}
