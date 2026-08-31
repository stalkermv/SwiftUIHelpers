//
//  LabelColorShapeStyleProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 04.06.2025.
//

#if canImport(UIKit)
import SwiftUI

/// A protocol that provides a label color derived from the current background shape style.
///
/// > EXPERIMENTAL — relies on private SwiftUI internals; may break without warning on any OS
/// > update; not covered by semver.
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
        var applied = false
        
        for child in mirror.children {
            if let label = child.label, label == "environment" {
                if let environment = child.value as? EnvironmentValues {
                    resolve(in: environment)._apply(to: &shape)
                } else {
                    assertionFailure("Unable to extract EnvironmentValues from _ShapeStyle_Shape")
                    resolve(in: EnvironmentValues())._apply(to: &shape)
                }
                applied = true
                break
            }
        }
        
        if !applied {
            resolve(in: EnvironmentValues())._apply(to: &shape)
        }
    }
}

extension Color: LabelColorShapeStyleProvider {
    public func resolveLabel(in environment: EnvironmentValues) -> Color {
        return self.accessibleFontColor
    }
}

#endif
