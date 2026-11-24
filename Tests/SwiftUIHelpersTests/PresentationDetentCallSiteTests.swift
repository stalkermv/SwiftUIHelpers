import SwiftUI
import Testing
import SwiftUIHelpers

/// The call site is the public API: `.presentationDetent(.fit)` must compile next
/// to SwiftUI's own `.presentationDetents(_:)` in a file that imports both.
@MainActor
struct PresentationDetentCallSiteTests {
    @Test("presentationDetent(.fit) compiles next to SwiftUI's presentationDetents")
    func callSiteCompiles() {
        _ = Text("sheet")
            .presentationDetent(.fit)

        _ = Text("sheet")
            .presentationDetents([.medium, .large])
            .presentationDetent(.fit)
    }

    @Test("The fit detent has a single case")
    func fitCase() {
        let detent: FitPresentationDetent = .fit
        #expect(detent == .fit)
    }
}
