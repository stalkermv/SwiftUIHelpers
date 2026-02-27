import SwiftUI

@available(iOS 17.0, *)
struct HierarchicalPaletteDemoScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HierarchicalPaletteDemoSection(
                    title: "Label",
                    rows: HierarchicalPaletteDemoCatalog.labelRows
                )

                HierarchicalPaletteDemoSection(
                    title: "Accent",
                    rows: HierarchicalPaletteDemoCatalog.accentRows
                )

                HierarchicalPaletteDemoSection(
                    title: "Background",
                    rows: HierarchicalPaletteDemoCatalog.backgroundRows
                )
            }
            .padding(16)
        }
        .navigationTitle("Hierarchical Palette")
        .background(Color.black.ignoresSafeArea())
    }
}

private struct HierarchicalPaletteDemoSection: View {
    let title: String
    let rows: [HierarchicalPaletteDemoRow]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)

            ForEach(rows) { row in
                HierarchicalPaletteDemoComparisonRow(row: row)
            }
        }
    }
}

private struct HierarchicalPaletteDemoComparisonRow: View {
    let row: HierarchicalPaletteDemoRow

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(row.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)

            HStack(spacing: 12) {
                HierarchicalPaletteDemoColumn(
                    title: "Canonical",
                    hex: row.hex,
                    style: AnyShapeStyle(Color.demoScreenHex(row.hex))
                )
                
                HierarchicalPaletteDemoColumn(
                    title: "Hierarchical Palette",
                    hex: row.hex,
                    style: row.style
                )
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white.opacity(0.06))
        )
    }
}

private struct HierarchicalPaletteDemoColumn: View {
    let title: String
    let hex: String
    let style: AnyShapeStyle

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))

            Text(hex)
                .font(.caption2.monospaced())
                .foregroundStyle(.white.opacity(0.7))

            HierarchicalPaletteDemoSwatch(background: .black, style: style)
            HierarchicalPaletteDemoSwatch(background: .red, style: style)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct HierarchicalPaletteDemoSwatch: View {
    let background: Color
    let style: AnyShapeStyle

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(background)

            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(style)
                .padding(6)
        }
        .frame(height: 34)
    }
}

#Preview("Visual Exact") {
    if #available(iOS 17.0, *) {
        NavigationStack {
            HierarchicalPaletteDemoScreen()
        }
        .hierarchicalPaletteConfiguration(.default)
    }
}

#Preview("Native") {
    if #available(iOS 17.0, *) {
        NavigationStack {
            HierarchicalPaletteDemoScreen()
        }
        .hierarchicalPaletteConfiguration(
            .init(
                alphaPolicy: .native,
                loggingEnabled: false
            )
        )
    }
}

private extension Color {
    static func demoScreenHex(_ hex: String) -> Color {
        let normalized = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        guard normalized.count == 6, let value = UInt64(normalized, radix: 16) else {
            return .clear
        }

        let red = Double((value >> 16) & 0xFF) / 255.0
        let green = Double((value >> 8) & 0xFF) / 255.0
        let blue = Double(value & 0xFF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }
}
