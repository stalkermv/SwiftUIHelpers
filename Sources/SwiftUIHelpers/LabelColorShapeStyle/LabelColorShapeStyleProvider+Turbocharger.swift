//
//  LabelColorShapeStyleProvider+Turbocharger.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 04.06.2025.
//

#if canImport(Engine)
import SwiftUI
import Engine

@available(iOS 16.0, *)
extension BackgroundStyle: LabelColorShapeStyleProvider {
    public func resolveLabel(in environment: EnvironmentValues) -> Color {
        environment.backgroundStyle?.color?.accessibleFontColor ?? .black
    }
}

extension TintShapeStyle:  LabelColorShapeStyleProvider {
    public func resolveLabel(in environment: EnvironmentValues) -> Color {
        environment.tint.color?.accessibleFontColor ?? .white
    }
}
#endif
