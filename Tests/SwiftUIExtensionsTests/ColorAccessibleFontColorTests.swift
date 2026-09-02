//
//  ColorAccessibleFontColorTests.swift
//  SwiftUIHelpers
//

import SwiftUI
import Testing
@testable import SwiftUIExtensions

/// Expected text colors derived from the WCAG relative-luminance rule used by
/// `Color.accessibleFontColor`: linearize each sRGB channel
/// (`c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055) ^ 2.4`), then
/// `L = 0.2126R + 0.7152G + 0.0722B`; `L > 0.179` picks black text.
///
/// - `#000000`: L = 0 → white text.
/// - `#FFFFFF`: L = 1 → black text.
/// - `#7F7F7F` ≈ 0.498: lin ≈ 0.214 → L > 0.179 → black text.
/// - `#B3B3B3` ≈ 0.702: lin ≈ 0.452 → L > 0.179 → black text.
/// - `#8460BD` ≈ (0.518, 0.376, 0.741): L ≈ 0.169 < 0.179 → white text.
/// - `#0A0A0A`: L ≈ 0.001 → white text.
private let accessibleFontColorCases: [(hex: Int, expectBlackText: Bool)] = [
    (0x000000, false),
    (0xFFFFFF, true),
    (0x7F7F7F, true),
    (0xB3B3B3, true),
    (0x8460BD, false),
    (0x0A0A0A, false),
]

@Suite("Accessible font color", .tags(.colors))
struct ColorAccessibleFontColorTests {
    @Test("Background color resolves to the readable text color", arguments: accessibleFontColorCases)
    func accessibleFontColorResolution(hex: Int, expectBlackText: Bool) throws {
        let background = Color(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )

        let text = try #require(components(of: background.accessibleFontColor))
        let expected = expectBlackText ? 0.0 : 1.0
        #expect(abs(text.r - expected) < 0.001)
        #expect(abs(text.g - expected) < 0.001)
        #expect(abs(text.b - expected) < 0.001)
    }
}
