//
//  TextSelectionGroupTests.swift
//  SwiftUIHelpersUnsafeTests
//

import SwiftUI
import Testing
@testable import SwiftUIHelpersUnsafe

#if canImport(AppKit)
import AppKit
#endif

@MainActor
@Suite("View.textSelectionGroup()")
struct TextSelectionGroupTests {
    /// The private modifier exists in OS 27 and later.
    private static let osHasPrivateModifier = ProcessInfo.processInfo.isOperatingSystemAtLeast(
        OperatingSystemVersion(majorVersion: 27, minorVersion: 0, patchVersion: 0)
    )

    @Test("Finds the private modifier exactly when the OS has it")
    func resolvesUnderlyingModifier() {
        #expect(TextSelectionGroupModifier.isSupported == Self.osHasPrivateModifier)
        #expect((TextSelectionGroupModifier.resolvedModifierType != nil) == TextSelectionGroupModifier.isSupported)
        if let resolved = TextSelectionGroupModifier.resolvedModifierType {
            #expect(String(describing: resolved) == "TextSelectionGroupModifier")
        }
    }

    @Test("Descriptor extractor rejects malformed opaque descriptors")
    func extractorRejectsInvalidDescriptor() {
        let fakeWords = [Int32](repeating: 0, count: 16)
        let result = fakeWords.withUnsafeBytes { rawBuffer in
            TextSelectionGroupModifier.extractModifierType(fromOpaqueDescriptor: rawBuffer.baseAddress!)
        }
        #expect(result == nil)
    }

    @Test("Descriptor extractor rejects a descriptor with a far away name")
    func extractorRejectsFarName() {
        var fakeWords = [Int32](repeating: 0, count: 16)
        fakeWords[0] = 4          // opaque type descriptor kind
        fakeWords[11] = 1 << 24   // name offset outside the plausible range
        let result = fakeWords.withUnsafeBytes { rawBuffer in
            TextSelectionGroupModifier.extractModifierType(fromOpaqueDescriptor: rawBuffer.baseAddress!)
        }
        #expect(result == nil)
    }

    @Test("Applying the modifier renders without crashing, with or without OS support")
    func rendersWithoutCrashing() {
        let view = VStack {
            Text("First line")
            Text("Second line")
        }
        .textSelectionGroup()
        .textSelection(.enabled)
        .frame(width: 200, height: 100)

        let image = ImageRenderer(content: view).cgImage
        #expect(image != nil)
    }

    #if canImport(AppKit)
    @Test("Merges selectable Text views into one AppKitTextInteractionView and skips a disabled Label")
    func coalescesTextInteractionViewsOnMacOS() {
        let ungrouped = VStack {
            Text("First line")
            Text("Second line")
            Label("Skipped label", systemImage: "star")
                .textSelection(.disabled)
        }
        .textSelection(.enabled)

        let grouped = VStack {
            Text("First line")
            Text("Second line")
            Label("Skipped label", systemImage: "star")
                .textSelection(.disabled)
        }
        .textSelectionGroup()
        .textSelection(.enabled)

        let ungroupedHost = NSHostingView(rootView: ungrouped)
        ungroupedHost.frame = NSRect(x: 0, y: 0, width: 300, height: 200)
        ungroupedHost.layoutSubtreeIfNeeded()

        let groupedHost = NSHostingView(rootView: grouped)
        groupedHost.frame = NSRect(x: 0, y: 0, width: 300, height: 200)
        groupedHost.layoutSubtreeIfNeeded()

        func countInteractionViews(in view: NSView) -> Int {
            let selfMatch = String(describing: type(of: view)).contains("TextInteractionView") ? 1 : 0
            return selfMatch + view.subviews.reduce(0) { $0 + countInteractionViews(in: $1) }
        }

        let ungroupedCount = countInteractionViews(in: ungroupedHost)
        let groupedCount = countInteractionViews(in: groupedHost)

        // Without `textSelectionGroup()`, each `Text` gets its own interaction view.
        #expect(ungroupedCount == 2)
        // On OS 27 and later SwiftUI shares one interaction view for the group; on earlier
        // versions the modifier does nothing, so the count is unchanged.
        #expect(groupedCount == (Self.osHasPrivateModifier ? 1 : 2))
    }
    #endif
}
