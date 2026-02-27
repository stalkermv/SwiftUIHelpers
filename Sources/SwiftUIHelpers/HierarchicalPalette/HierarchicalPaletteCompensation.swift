import Foundation

/// Multipliers used to compensate SwiftUI hierarchical attenuation for non-primary levels.
///
/// Use this type with ``HierarchicalPaletteAlphaPolicy/visualExact(_:)`` when you need the
/// final on-screen color to visually match canonical design tokens.
public struct HierarchicalPaletteCompensation: Sendable, Equatable {
    /// Compensation multiplier for ``HierarchicalPaletteLevel/secondary``.
    public let secondary: Double

    /// Compensation multiplier for ``HierarchicalPaletteLevel/tertiary``.
    public let tertiary: Double

    /// Compensation multiplier for ``HierarchicalPaletteLevel/quaternary``.
    public let quaternary: Double

    /// Compensation multiplier for ``HierarchicalPaletteLevel/quinary``.
    public let quinary: Double

    /// Creates a compensation profile.
    /// - Parameters:
    ///   - secondary: Multiplier for secondary level.
    ///   - tertiary: Multiplier for tertiary level.
    ///   - quaternary: Multiplier for quaternary level.
    ///   - quinary: Multiplier for quinary level.
    public init(
        secondary: Double,
        tertiary: Double,
        quaternary: Double,
        quinary: Double
    ) {
        self.secondary = secondary
        self.tertiary = tertiary
        self.quaternary = quaternary
        self.quinary = quinary
    }

    /// Returns a multiplier for the provided level.
    ///
    /// Primary uses `1.0` by design and should not be compensated.
    /// - Parameter level: Semantic hierarchy level.
    public func multiplier(for level: HierarchicalPaletteLevel) -> Double {
        switch level {
        case .primary:
            return 1.0
        case .secondary:
            return secondary
        case .tertiary:
            return tertiary
        case .quaternary:
            return quaternary
        case .quinary:
            return quinary
        }
    }
}

public extension HierarchicalPaletteCompensation {
    /// Default compensation values measured against the current SwiftUI runtime.
    ///
    /// Default values are:
    /// - secondary: `255 / 128` (`1.9921875`)
    /// - tertiary: `255 / 64` (`3.984375`)
    /// - quaternary: `255 / 46` (`5.5434782609`)
    /// - quinary: `255 / 46` (`5.5434782609`)
    ///
    /// Portability note:
    /// SwiftUI internals can evolve between major OS versions, so these values may require
    /// re-calibration in future runtimes.
    static let `default` = HierarchicalPaletteCompensation(
        secondary: 255.0 / 128.0,
        tertiary: 255.0 / 64.0,
        quaternary: 255.0 / 46.0,
        quinary: 255.0 / 46.0
    )
}
