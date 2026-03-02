import SwiftUI

struct HierarchicalPaletteDemoRow: Identifiable {
    let title: String
    let hex: String
    let style: AnyShapeStyle

    var id: String { title }
}


@available(iOS 17.0, *)
enum HierarchicalPaletteDemoCatalog {
    static let labelRows: [HierarchicalPaletteDemoRow] = [
        .init(title: ".demoLabel", hex: DemoPalette.label.primary, style: AnyShapeStyle(DemoLabelShapeStyle())),
        .init(title: ".demoLabel.secondary", hex: DemoPalette.label.secondary, style: AnyShapeStyle(DemoLabelShapeStyle().secondary)),
        .init(title: ".demoLabel.tertiary", hex: DemoPalette.label.tertiary, style: AnyShapeStyle(DemoLabelShapeStyle().tertiary)),
        .init(title: ".demoLabel.quaternary", hex: DemoPalette.label.quaternary, style: AnyShapeStyle(DemoLabelShapeStyle().quaternary)),
    ]

    static let accentRows: [HierarchicalPaletteDemoRow] = [
        .init(title: ".demoAccent", hex: DemoPalette.accent.primary, style: AnyShapeStyle(DemoAccentShapeStyle())),
        .init(title: ".demoAccent.secondary", hex: DemoPalette.accent.secondary, style: AnyShapeStyle(DemoAccentShapeStyle().secondary)),
        .init(title: ".demoAccent.tertiary", hex: DemoPalette.accent.tertiary, style: AnyShapeStyle(DemoAccentShapeStyle().tertiary)),
        .init(title: ".demoAccent.quaternary", hex: DemoPalette.accent.quaternary, style: AnyShapeStyle(DemoAccentShapeStyle().quaternary)),
    ]

    static let backgroundRows: [HierarchicalPaletteDemoRow] = [
        .init(title: ".demoBackground", hex: DemoPalette.background.primary, style: AnyShapeStyle(DemoBackgroundShapeStyle())),
        .init(title: ".demoBackground.secondary", hex: DemoPalette.background.secondary, style: AnyShapeStyle(DemoBackgroundShapeStyle().secondary)),
        .init(title: ".demoBackground.tertiary", hex: DemoPalette.background.tertiary, style: AnyShapeStyle(DemoBackgroundShapeStyle().tertiary)),
        .init(title: ".demoBackground.quaternary", hex: DemoPalette.background.quaternary, style: AnyShapeStyle(DemoBackgroundShapeStyle().quaternary)),
    ]
}

private enum DemoPalette {
    enum background {
        static let primary = "#0A0A0A"
        static let secondary = "#101010"
        static let tertiary = "#1C1C1E"
        static let quaternary = "#1C1C1E"
    }

    enum label {
        static let primary = "#FFFFFF"
        static let secondary = "#8B8F9B"
        static let tertiary = "#727272"
        static let quaternary = "#A7A9AC"
    }

    enum accent {
        static let primary = "#8460BD"
        static let secondary = "#7D6EFF"
        static let tertiary = "#6D98FF"
        static let quaternary = "#A1ACFF"
    }
}

@available(iOS 17.0, *)
private struct DemoBackgroundShapeStyle: HierarchicalPaletteShapeStyle {
    func resolve(in environment: EnvironmentValues, for level: HierarchicalPaletteLevel) -> Color {
        switch level {
        case .primary:
            return .demoHex(DemoPalette.background.primary)
        case .secondary:
            return .demoHex(DemoPalette.background.secondary)
        case .tertiary, .quaternary, .quinary:
            return .demoHex(DemoPalette.background.quaternary)
        }
    }
}

@available(iOS 17.0, *)
private struct DemoLabelShapeStyle: HierarchicalPaletteShapeStyle {
    func resolve(in environment: EnvironmentValues, for level: HierarchicalPaletteLevel) -> Color {
        switch level {
        case .primary:
            return .demoHex(DemoPalette.label.primary)
        case .secondary:
            return .demoHex(DemoPalette.label.secondary)
        case .tertiary:
            return .demoHex(DemoPalette.label.tertiary)
        case .quaternary, .quinary:
            return .demoHex(DemoPalette.label.quaternary)
        }
    }
}

@available(iOS 17.0, *)
private struct DemoAccentShapeStyle: HierarchicalPaletteShapeStyle {
    func resolve(in environment: EnvironmentValues, for level: HierarchicalPaletteLevel) -> Color {
        switch level {
        case .primary:
            return .demoHex(DemoPalette.accent.primary)
        case .secondary:
            return .demoHex(DemoPalette.accent.secondary)
        case .tertiary:
            return .demoHex(DemoPalette.accent.tertiary)
        case .quaternary, .quinary:
            return .demoHex(DemoPalette.accent.quaternary)
        }
    }
}

private extension Color {
    static func demoHex(_ hex: String) -> Color {
        let normalized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        guard normalized.count == 6, let value = UInt64(normalized, radix: 16) else {
            return .clear
        }

        let red = Double((value >> 16) & 0xFF) / 255.0
        let green = Double((value >> 8) & 0xFF) / 255.0
        let blue = Double(value & 0xFF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }
}
