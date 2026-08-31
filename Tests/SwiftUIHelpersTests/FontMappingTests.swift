import Testing
import SwiftUI
@testable import SwiftUIHelpers

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

struct FontMappingTests {
    // MARK: - Font.TextStyle → PlatformTextStyle (12 cases on iOS, 11 on macOS)
    @Test func textStyle_largeTitle() { _ = PlatformTextStyle(.largeTitle) }
    @Test func textStyle_title()      { _ = PlatformTextStyle(.title) }
    @Test func textStyle_title2()     { _ = PlatformTextStyle(.title2) }
    @Test func textStyle_title3()     { _ = PlatformTextStyle(.title3) }
    @Test func textStyle_headline()   { _ = PlatformTextStyle(.headline) }
    @Test func textStyle_body()       { _ = PlatformTextStyle(.body) }
    @Test func textStyle_callout()    { _ = PlatformTextStyle(.callout) }
    @Test func textStyle_subheadline(){ _ = PlatformTextStyle(.subheadline) }
    @Test func textStyle_footnote()   { _ = PlatformTextStyle(.footnote) }
    @Test func textStyle_caption()    { _ = PlatformTextStyle(.caption) }
    @Test func textStyle_caption2()   { _ = PlatformTextStyle(.caption2) }

    // MARK: - Font.Weight → PlatformFontWeight (9 cases)
    @Test func weight_ultraLight()    { #expect(PlatformFontWeight(.ultraLight) == .ultraLight) }
    @Test func weight_thin()          { #expect(PlatformFontWeight(.thin) == .thin) }
    @Test func weight_light()         { #expect(PlatformFontWeight(.light) == .light) }
    @Test func weight_regular()       { #expect(PlatformFontWeight(.regular) == .regular) }
    @Test func weight_medium()        { #expect(PlatformFontWeight(.medium) == .medium) }
    @Test func weight_semibold()      { #expect(PlatformFontWeight(.semibold) == .semibold) }
    @Test func weight_bold()          { #expect(PlatformFontWeight(.bold) == .bold) }
    @Test func weight_heavy()         { #expect(PlatformFontWeight(.heavy) == .heavy) }
    @Test func weight_black()         { #expect(PlatformFontWeight(.black) == .black) }

    // MARK: - Font.Design → PlatformSystemDesign (4 cases)
    @Test func design_default()       { #expect(PlatformSystemDesign(.default) == .default) }
    @Test func design_serif()         { #expect(PlatformSystemDesign(.serif) == .serif) }
    @Test func design_rounded()       { #expect(PlatformSystemDesign(.rounded) == .rounded) }
    @Test func design_monospaced()    { #expect(PlatformSystemDesign(.monospaced) == .monospaced) }
}
