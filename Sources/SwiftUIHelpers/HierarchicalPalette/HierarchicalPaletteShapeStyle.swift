import SwiftUI
import Logging

/// A shape style protocol that resolves semantic palette colors by hierarchical level.
///
/// Use this protocol to define type-driven semantic colors that can participate in SwiftUI
/// hierarchical foreground resolution (`primary`, `secondary`, `tertiary`, and so on).
///
/// Example:
/// ```swift
/// struct BackgroundShapeStyle: HierarchicalPaletteShapeStyle {
///     func resolve(in environment: EnvironmentValues, for level: HierarchicalPaletteLevel) -> Color {
///         switch level {
///         case .primary: return .black
///         case .secondary: return .gray
///         case .tertiary: return .gray.opacity(0.8)
///         case .quaternary, .quinary: return .gray.opacity(0.7)
///         }
///     }
/// }
/// ```
public protocol HierarchicalPaletteShapeStyle: ShapeStyle {
    /// Resolves a canonical color for the requested semantic hierarchy level.
    /// - Parameters:
    ///   - environment: Current SwiftUI environment.
    ///   - level: Semantic hierarchy level requested by the rendering pipeline.
    func resolve(in environment: EnvironmentValues, for level: HierarchicalPaletteLevel) -> Color
}

public extension HierarchicalPaletteShapeStyle {

    /// This method relies on `SwiftUI._ShapeStyle_Shape` introspection (`Mirror`) and therefore
    /// depends on private SwiftUI internals that may change across OS versions.
    ///
    /// Behavior:
    /// - extracts environment and operation metadata
    /// - resolves a semantic level
    /// - optionally applies visual-exact compensation for non-primary levels
    /// - applies the resolved color back to the shape
    func _apply(to shape: inout SwiftUI._ShapeStyle_Shape) {
        guard let environment = HierarchicalPaletteIntrospection.environment(from: shape) else {
            assertionFailure("Unable to extract EnvironmentValues from _ShapeStyle_Shape")
            return
        }

        let operationInfo = HierarchicalPaletteIntrospection.operationInfo(from: shape)
        let requestedLevel = HierarchicalPaletteLevel(rawLevel: operationInfo.level ?? 0)
        let configuration = environment.hierarchicalPaletteConfiguration

        var resolvedColor = resolve(in: environment, for: requestedLevel)
        let compensationMultiplier = compensationMultiplier(
            for: requestedLevel,
            operationKind: operationInfo.kind,
            policy: configuration.alphaPolicy
        )

        if let compensationMultiplier {
            resolvedColor = resolvedColor.opacity(compensationMultiplier)
        }

        if configuration.loggingEnabled {
            let compensationDescription = compensationMultiplier.map { String($0) } ?? "none"
            Logger.hierarchicalPalette.debug(
                "style=\(String(describing: Self.self)) op=\(operationInfo.kind.rawValue) level=\(requestedLevel.rawValue) src=\(operationInfo.levelSource) role=\(HierarchicalPaletteIntrospection.role(from: shape)) substrate=\(HierarchicalPaletteIntrospection.substrate(from: shape)) compensation=\(compensationDescription)"
            )
        }

        resolvedColor._apply(to: &shape)
    }

    private func compensationMultiplier(
        for level: HierarchicalPaletteLevel,
        operationKind: HierarchicalPaletteOperationKind,
        policy: HierarchicalPaletteAlphaPolicy
    ) -> Double? {
        guard !level.isPrimary else { return nil }
        guard operationKind == .resolveStyle || operationKind == .prepareText else { return nil }

        switch policy {
        case .native:
            return nil
        case let .visualExact(compensation):
            return compensation.multiplier(for: level)
        }
    }
}
