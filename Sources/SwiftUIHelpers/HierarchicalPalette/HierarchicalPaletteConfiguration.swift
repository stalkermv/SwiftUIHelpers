import SwiftUI

/// Policy that controls how hierarchical non-primary levels are rendered.
public enum HierarchicalPaletteAlphaPolicy: Sendable, Equatable {
    /// Keep native SwiftUI attenuation for secondary and deeper levels.
    case native

    /// Compensate native attenuation to preserve visual parity with canonical palette colors.
    /// - Parameter compensation: Multipliers applied to non-primary levels.
    case visualExact(HierarchicalPaletteCompensation)
}

/// Runtime configuration used by ``HierarchicalPaletteShapeStyle`` resolution.
public struct HierarchicalPaletteConfiguration: Sendable, Equatable {
    /// Alpha policy applied during style resolution.
    public var alphaPolicy: HierarchicalPaletteAlphaPolicy

    /// Creates a configuration object.
    /// - Parameter alphaPolicy: Hierarchical alpha handling policy.
    public init(alphaPolicy: HierarchicalPaletteAlphaPolicy) {
        self.alphaPolicy = alphaPolicy
    }
}

public extension HierarchicalPaletteConfiguration {
    /// Default configuration.
    ///
    /// Uses visual-exact compensation.
    static let `default` = HierarchicalPaletteConfiguration(alphaPolicy: .visualExact(.default))
}

private struct HierarchicalPaletteConfigurationKey: EnvironmentKey {
    static let defaultValue: HierarchicalPaletteConfiguration = .default
}

public extension EnvironmentValues {
    /// Configuration used by hierarchical palette style resolvers.
    var hierarchicalPaletteConfiguration: HierarchicalPaletteConfiguration {
        get { self[HierarchicalPaletteConfigurationKey.self] }
        set { self[HierarchicalPaletteConfigurationKey.self] = newValue }
    }
}

public extension View {
    /// Applies hierarchical palette configuration for this view subtree.
    /// - Parameter configuration: Resolver configuration.
    func hierarchicalPaletteConfiguration(_ configuration: HierarchicalPaletteConfiguration) -> some View {
        environment(\.hierarchicalPaletteConfiguration, configuration)
    }
}
