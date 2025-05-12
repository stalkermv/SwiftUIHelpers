import SwiftUI
import Testing
@testable import SwiftUIExtensions

struct ColorAccessibleFontColorTests {
    @Test func testAccessibleFontColorReturnsBlackForLightColors() {
        let lightColor = Color(red: 0.9, green: 0.9, blue: 0.9)
        #expect(lightColor.accessibleFontColor == .black)
    }

    @Test func testAccessibleFontColorReturnsWhiteForDarkColors() {
        let darkColor = Color(red: 0.1, green: 0.1, blue: 0.1)
        #expect(darkColor.accessibleFontColor == .white)
    }

    @Test func testAccessibleFontColorEdgeCase() {
        let midColor = Color(red: 0.7, green: 0.7, blue: 0.6)
        // According to the isLightColor logic, this should be black
        #expect(midColor.accessibleFontColor == .black)
    }
}
