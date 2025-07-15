//
//  ApplicationMiddlewareBuilder.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 17.06.2025.
//

import SwiftUI

@resultBuilder
public struct ApplicationMiddlewareBuilder {
    
    public static func buildBlock<M: ApplicationMiddleware>(_ middleware: M) -> some ApplicationMiddleware {
        middleware
    }
    
    public static func buildBlock<M1: ApplicationMiddleware, M2: ApplicationMiddleware>(
        _ middleware1: M1,
        _ middleware2: M2
    ) -> ModifiedContent<M1, M2> {
        middleware1.concat(middleware2)
    }
    
    public static func buildBlock<M1: ApplicationMiddleware, M2: ApplicationMiddleware, M3: ApplicationMiddleware>(
        _ middleware1: M1,
        _ middleware2: M2,
        _ middleware3: M3
    ) -> ModifiedContent<ModifiedContent<M1, M2>, M3> {
        middleware1.concat(middleware2).concat(middleware3)
    }
    
    public static func buildBlock<M1: ApplicationMiddleware, M2: ApplicationMiddleware, M3: ApplicationMiddleware, M4: ApplicationMiddleware>(
        _ middleware1: M1,
        _ middleware2: M2,
        _ middleware3: M3,
        _ middleware4: M4
    ) -> ModifiedContent<ModifiedContent<ModifiedContent<M1, M2>, M3>, M4> {
        middleware1.concat(middleware2).concat(middleware3).concat(middleware4)
    }
    
    public static func buildBlock<M1: ApplicationMiddleware, M2: ApplicationMiddleware, M3: ApplicationMiddleware, M4: ApplicationMiddleware, M5: ApplicationMiddleware>(
        _ middleware1: M1,
        _ middleware2: M2,
        _ middleware3: M3,
        _ middleware4: M4,
        _ middleware5: M5
    ) -> ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<M1, M2>, M3>, M4>, M5> {
        middleware1.concat(middleware2).concat(middleware3).concat(middleware4).concat(middleware5)
    }
    
    public static func buildBlock<M1: ApplicationMiddleware, M2: ApplicationMiddleware, M3: ApplicationMiddleware, M4: ApplicationMiddleware, M5: ApplicationMiddleware, M6: ApplicationMiddleware>(
        _ middleware1: M1,
        _ middleware2: M2,
        _ middleware3: M3,
        _ middleware4: M4,
        _ middleware5: M5,
        _ middleware6: M6
    ) -> ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<M1, M2>, M3>, M4>, M5>, M6> {
        middleware1.concat(middleware2).concat(middleware3).concat(middleware4).concat(middleware5).concat(middleware6)
    }
    
    public static func buildBlock<M1: ApplicationMiddleware, M2: ApplicationMiddleware, M3: ApplicationMiddleware, M4: ApplicationMiddleware, M5: ApplicationMiddleware, M6: ApplicationMiddleware, M7: ApplicationMiddleware>(
        _ middleware1: M1,
        _ middleware2: M2,
        _ middleware3: M3,
        _ middleware4: M4,
        _ middleware5: M5,
        _ middleware6: M6,
        _ middleware7: M7
    ) -> ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<M1, M2>, M3>, M4>, M5>, M6>, M7> {
        middleware1.concat(middleware2).concat(middleware3).concat(middleware4).concat(middleware5).concat(middleware6).concat(middleware7)
    }
    
    public static func buildBlock<M1: ApplicationMiddleware, M2: ApplicationMiddleware, M3: ApplicationMiddleware, M4: ApplicationMiddleware, M5: ApplicationMiddleware, M6: ApplicationMiddleware, M7: ApplicationMiddleware, M8: ApplicationMiddleware>(
        _ middleware1: M1,
        _ middleware2: M2,
        _ middleware3: M3,
        _ middleware4: M4,
        _ middleware5: M5,
        _ middleware6: M6,
        _ middleware7: M7,
        _ middleware8: M8
    ) -> ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<M1, M2>, M3>, M4>, M5>, M6>, M7>, M8> {
        middleware1.concat(middleware2).concat(middleware3).concat(middleware4).concat(middleware5).concat(middleware6).concat(middleware7).concat(middleware8)
    }
    
    
}

#if canImport(Engine)
import Engine

extension ApplicationMiddlewareBuilder {
    @MainActor public static func buildBlock<each M: ApplicationMiddleware>(_ middlewares: repeat each M) -> some ViewModifier {
        var result: AnyViewModifier = AnyViewModifier(EmptyModifier())
        for middleware in repeat each middlewares {
            result = result.concat(middleware)
        }
        
        return result
    }
}
#endif
