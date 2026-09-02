import Testing
import SwiftUI
@testable import SwiftUIHelpers

#if canImport(UIKit)
import UIKit

/// UIKit maps `Font.TextStyle` to `UIFont.TextStyle`, collapsing `.title` to
/// `.title1` and `.caption` to `.caption1` (there's no separate first-tier
/// case on this platform). 11 cases — `extraLargeTitle` has no `UIFont.TextStyle`
/// counterpart.
private let textStyleCases: [(style: Font.TextStyle, expected: PlatformTextStyle)] = [
    (.largeTitle, .largeTitle),
    (.title, .title1),
    (.title2, .title2),
    (.title3, .title3),
    (.headline, .headline),
    (.body, .body),
    (.callout, .callout),
    (.subheadline, .subheadline),
    (.footnote, .footnote),
    (.caption, .caption1),
    (.caption2, .caption2),
]
#else
import AppKit

/// macOS collapses further: `.largeTitle → .title1` (no distinct large-title
/// tier) and `.callout → .body` (no distinct callout tier). 11 cases.
private let textStyleCases: [(style: Font.TextStyle, expected: PlatformTextStyle)] = [
    (.largeTitle, .title1),
    (.title, .title1),
    (.title2, .title2),
    (.title3, .title3),
    (.headline, .headline),
    (.body, .body),
    (.callout, .body),
    (.subheadline, .subheadline),
    (.footnote, .footnote),
    (.caption, .caption1),
    (.caption2, .caption2),
]
#endif

private let fontWeightCases: [(weight: Font.Weight, expected: PlatformFontWeight)] = [
    (.ultraLight, .ultraLight),
    (.thin, .thin),
    (.light, .light),
    (.regular, .regular),
    (.medium, .medium),
    (.semibold, .semibold),
    (.bold, .bold),
    (.heavy, .heavy),
    (.black, .black),
]

private let fontDesignCases: [(design: Font.Design, expected: PlatformSystemDesign)] = [
    (.default, .default),
    (.serif, .serif),
    (.rounded, .rounded),
    (.monospaced, .monospaced),
]

@Suite("Font mapping", .tags(.fonts))
struct FontMappingTests {
    @Test("Font.TextStyle maps to the platform text style", arguments: textStyleCases)
    func textStyleMapping(style: Font.TextStyle, expected: PlatformTextStyle) {
        #expect(PlatformTextStyle(style) == expected)
    }

    @Test("Font.Weight maps to the platform font weight", arguments: fontWeightCases)
    func fontWeightMapping(weight: Font.Weight, expected: PlatformFontWeight) {
        #expect(PlatformFontWeight(weight) == expected)
    }

    @Test("Font.Design maps to the platform system design", arguments: fontDesignCases)
    func fontDesignMapping(design: Font.Design, expected: PlatformSystemDesign) {
        #expect(PlatformSystemDesign(design) == expected)
    }
}
