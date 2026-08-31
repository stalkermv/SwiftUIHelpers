//
//  ColorAccessibleFontColorTests.swift
//  SwiftUIHelpers
//

import SwiftUI
import Testing
@testable import SwiftUIExtensions

struct ColorAccessibleFontColorTests {
    // (0,0,0) — black: L=0 → white text
    @Test func black_background_returns_white_text() throws {
        let result = try #require(components(of: Color(red: 0, green: 0, blue: 0).accessibleFontColor))
        #expect(abs(result.r - 1) < 0.001)
        #expect(abs(result.g - 1) < 0.001)
        #expect(abs(result.b - 1) < 0.001)
    }

    // (1,1,1) — white: L=1 → black text
    @Test func white_background_returns_black_text() throws {
        let result = try #require(components(of: Color(red: 1, green: 1, blue: 1).accessibleFontColor))
        #expect(abs(result.r - 0) < 0.001)
        #expect(abs(result.g - 0) < 0.001)
        #expect(abs(result.b - 0) < 0.001)
    }

    // #7F7F7F ≈ (0.498, 0.498, 0.498)
    // lin(0.498) ≈ ((0.498+0.055)/1.055)^2.4 ≈ 0.2140
    // L ≈ 0.2140 > 0.179 → black text
    @Test func mid_gray_7F7F7F_returns_black_text() throws {
        let result = try #require(components(of: Color(red: 0x7F/255.0, green: 0x7F/255.0, blue: 0x7F/255.0).accessibleFontColor))
        #expect(abs(result.r - 0) < 0.001)
        #expect(abs(result.g - 0) < 0.001)
        #expect(abs(result.b - 0) < 0.001)
    }

    // #B3B3B3 ≈ (0.702, 0.702, 0.702)
    // lin(0.702) ≈ 0.4520 → L ≈ 0.4520 > 0.179 → black text
    @Test func light_gray_B3B3B3_returns_black_text() throws {
        let result = try #require(components(of: Color(red: 0xB3/255.0, green: 0xB3/255.0, blue: 0xB3/255.0).accessibleFontColor))
        #expect(abs(result.r - 0) < 0.001)
        #expect(abs(result.g - 0) < 0.001)
        #expect(abs(result.b - 0) < 0.001)
    }

    // #8460BD = (0x84/255≈0.518, 0x60/255≈0.376, 0xBD/255≈0.741)
    // lin(0.518)≈0.2348, lin(0.376)≈0.1159, lin(0.741)≈0.5031
    // L ≈ 0.2126*0.2348 + 0.7152*0.1159 + 0.0722*0.5031 ≈ 0.1691 < 0.179 → white text
    @Test func purple_8460BD_returns_white_text() throws {
        let result = try #require(components(of: Color(red: 0x84/255.0, green: 0x60/255.0, blue: 0xBD/255.0).accessibleFontColor))
        #expect(abs(result.r - 1) < 0.001)
        #expect(abs(result.g - 1) < 0.001)
        #expect(abs(result.b - 1) < 0.001)
    }

    // #0A0A0A — near black: L ≈ 0.001 → white text
    @Test func near_black_0A0A0A_returns_white_text() throws {
        let result = try #require(components(of: Color(red: 0x0A/255.0, green: 0x0A/255.0, blue: 0x0A/255.0).accessibleFontColor))
        #expect(abs(result.r - 1) < 0.001)
        #expect(abs(result.g - 1) < 0.001)
        #expect(abs(result.b - 1) < 0.001)
    }
}
