//
//  LabelColorShapeStyleProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 04.06.2025.
//

#if canImport(UIKit)
import SwiftUI

public protocol LabelColorShapeStyleProvider: Sendable {
    func resolveLabel(in environment: EnvironmentValues) -> Color
}

extension ShapeStyle where Self: LabelColorShapeStyleProvider {
    public var label: some ShapeStyle {
        LabelColorShapeStyle(self)
    }
}

struct LabelColorShapeStyle<Shape: LabelColorShapeStyleProvider>: ShapeStyle {
    private var resolve: Shape
    
    init(_ style: Shape) {
        resolve = style
    }
    
    func resolve(in environment: EnvironmentValues) -> Color {
        resolve.resolveLabel(in: environment)
    }
    
    func _apply(to shape: inout SwiftUI._ShapeStyle_Shape) {
        let mirror = Mirror(reflecting: shape)
        
        for child in mirror.children {
            if let label = child.label, label == "environment" {
                if let environment = child.value as? EnvironmentValues {
                    resolve(in: environment)._apply(to: &shape)
                } else {
                    fatalError("Unable to cast environment")
                }
                break
            }
        }
    }
}

extension Color: LabelColorShapeStyleProvider {
    public func resolveLabel(in environment: EnvironmentValues) -> Color {
        return self.accessibleFontColor
    }
}

#endif
