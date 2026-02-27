import Foundation

/// Semantic hierarchy levels used by ``HierarchicalPaletteShapeStyle``.
///
/// These levels mirror SwiftUI's hierarchical foreground model (`primary` through `quinary`).
public enum HierarchicalPaletteLevel: Int, Sendable, CaseIterable {
    /// The base semantic foreground level.
    case primary = 0

    /// The second semantic foreground level.
    case secondary = 1

    /// The third semantic foreground level.
    case tertiary = 2

    /// The fourth semantic foreground level.
    case quaternary = 3

    /// The fifth semantic foreground level.
    case quinary = 4

    /// Creates a safe level from a raw integer.
    ///
    /// Any unknown value falls back to ``primary``.
    /// - Parameter rawLevel: Raw hierarchy level extracted from SwiftUI internals.
    public init(rawLevel: Int) {
        self = HierarchicalPaletteLevel(rawValue: rawLevel) ?? .primary
    }

    /// Indicates whether this level is the base foreground level.
    public var isPrimary: Bool {
        self == .primary
    }
}
