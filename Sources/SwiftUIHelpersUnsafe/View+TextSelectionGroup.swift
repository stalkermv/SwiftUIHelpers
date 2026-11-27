//
//  View+TextSelectionGroup.swift
//  SwiftUIHelpersUnsafe
//

import Darwin
import SwiftUI
import os

extension View {
    /// Groups selectable `Text` views inside this view into one text-selection region.
    ///
    /// Dragging across several `Text` views selects and copies their text together, in
    /// layout order. Views marked with `.textSelection(.disabled)`, such as a `Label`, are
    /// skipped.
    ///
    /// This is an experimental helper that uses a private SwiftUI modifier:
    ///
    /// - The modifier exists in OS 27.2 and later (it is missing on 27.0). On earlier versions, and whenever it cannot be
    ///   found or does not look as expected, `textSelectionGroup()` does nothing and the view
    ///   behaves as if it were not applied. Check ``TextSelectionGroupModifier/isSupported``
    ///   to find out which case applies.
    /// - The private modifier is looked up by name when it is first used, so the library still
    ///   loads on older OS versions.
    /// - It can break on any OS update, is not covered by semantic versioning, and should not
    ///   be shipped in App Store apps.
    ///
    /// ```swift
    /// VStack(alignment: .leading) {
    ///     Text("First paragraph")
    ///     Text("Second paragraph")
    /// }
    /// .textSelectionGroup()
    /// .textSelection(.enabled)
    /// ```
    public func textSelectionGroup() -> ModifiedContent<Self, TextSelectionGroupModifier> {
        modifier(TextSelectionGroupModifier())
    }
}

/// A `ViewModifier` that forwards to SwiftUI's private `TextSelectionGroupModifier` when the
/// running OS has it, and does nothing otherwise.
///
/// Experimental: it relies on a private SwiftUI modifier, can break on any OS update, is not
/// covered by semantic versioning, and should not be shipped in App Store apps. Use
/// ``SwiftUICore/View/textSelectionGroup()`` instead of creating it directly.
public struct TextSelectionGroupModifier: ViewModifier, Sendable {
    public typealias Body = Never

    public init() {}

    /// Whether the running OS provides the private text selection group modifier.
    ///
    /// When this is `false`, ``SwiftUICore/View/textSelectionGroup()`` does nothing.
    public static var isSupported: Bool {
        resolvedModifierType != nil
    }

    nonisolated public static func _makeView(
        modifier: _GraphValue<Self>,
        inputs: _ViewInputs,
        body: @escaping (_Graph, _ViewInputs) -> _ViewOutputs
    ) -> _ViewOutputs {
        let underlying = resolvedModifierType ?? EmptyModifier.self
        return makeUnderlyingView(underlying, modifier: modifier, inputs: inputs, body: body)
    }

    nonisolated public static func _makeViewList(
        modifier: _GraphValue<Self>,
        inputs: _ViewListInputs,
        body: @escaping (_Graph, _ViewListInputs) -> _ViewListOutputs
    ) -> _ViewListOutputs {
        let underlying = resolvedModifierType ?? EmptyModifier.self
        return makeUnderlyingViewList(underlying, modifier: modifier, inputs: inputs, body: body)
    }

    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    nonisolated public static func _viewListCount(
        inputs: _ViewListCountInputs,
        body: (_ViewListCountInputs) -> Int?
    ) -> Int? {
        let underlying = resolvedModifierType ?? EmptyModifier.self
        return underlyingViewListCount(underlying, inputs: inputs, body: body)
    }

    nonisolated private static func makeUnderlyingView<M: ViewModifier>(
        _ type: M.Type,
        modifier: _GraphValue<Self>,
        inputs: _ViewInputs,
        body: @escaping (_Graph, _ViewInputs) -> _ViewOutputs
    ) -> _ViewOutputs {
        // Both `Self` and the resolved `TextSelectionGroupModifier` (or `EmptyModifier`)
        // are zero-sized `ViewModifier`s with `Body == Never`, so `_GraphValue<Self>` and
        // `_GraphValue<M>` have identical representations.
        let casted = unsafeBitCast(modifier, to: _GraphValue<M>.self)
        return M._makeView(modifier: casted, inputs: inputs, body: body)
    }

    nonisolated private static func makeUnderlyingViewList<M: ViewModifier>(
        _ type: M.Type,
        modifier: _GraphValue<Self>,
        inputs: _ViewListInputs,
        body: @escaping (_Graph, _ViewListInputs) -> _ViewListOutputs
    ) -> _ViewListOutputs {
        let casted = unsafeBitCast(modifier, to: _GraphValue<M>.self)
        return M._makeViewList(modifier: casted, inputs: inputs, body: body)
    }

    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    nonisolated private static func underlyingViewListCount<M: ViewModifier>(
        _ type: M.Type,
        inputs: _ViewListCountInputs,
        body: (_ViewListCountInputs) -> Int?
    ) -> Int? {
        M._viewListCount(inputs: inputs, body: body)
    }

    /// Candidate opaque return type descriptors (`QOMQ`) for `View._textSelectionGroup*()`,
    /// ordered from newest to oldest.
    nonisolated static let candidateOpaqueDescriptorSymbols: [String] = [
        "$s7SwiftUI4ViewPAAE18textSelectionGroupQryFQOMQ",
        "$s7SwiftUI4ViewPAAE19_textSelectionGroupQryFQOMQ",
        "$s7SwiftUI4ViewPAAE22_textSelectionGroup_v3QryFQOMQ",
        "$s7SwiftUI4ViewPAAE22_textSelectionGroup_v2QryFQOMQ",
        "$s7SwiftUI4ViewPAAE22_textSelectionGroup_v1QryFQOMQ",
    ]

    nonisolated(unsafe) static let resolvedModifierType: (any ViewModifier.Type)? = {
        let rtldDefault = UnsafeMutableRawPointer(bitPattern: -2)
        let handle = dlopen("/System/Library/Frameworks/SwiftUI.framework/SwiftUI", RTLD_LAZY | RTLD_NOLOAD)
            ?? dlopen("/System/Library/Frameworks/SwiftUI.framework/SwiftUI", RTLD_LAZY)
            ?? rtldDefault

        for symbol in candidateOpaqueDescriptorSymbols {
            if let qomq = dlsym(handle, symbol) ?? (rtldDefault.flatMap { dlsym($0, symbol) }),
               let modifierType = extractModifierType(fromOpaqueDescriptor: qomq) {
                return modifierType
            }
        }

        Logger(subsystem: "SwiftUIHelpersUnsafe", category: "TextSelectionGroup")
            .info("The private SwiftUI text selection group modifier was not found on this OS; textSelectionGroup() does nothing.")
        return nil
    }()

    /// Reads the `OpaqueTypeDescriptor` of `View._textSelectionGroup*()` and extracts the
    /// metatype of the underlying zero-sized `ViewModifier` inside `ModifiedContent<Self, Modifier>`.
    nonisolated static func extractModifierType(
        fromOpaqueDescriptor qomq: UnsafeRawPointer
    ) -> (any ViewModifier.Type)? {
        // Layout of an OpaqueTypeDescriptor for a `View` extension method with signature
        // `<Self where Self: View> (Self) -> some View`:
        // - +0x00: flags (UInt32) — ContextDescriptorKind::OpaqueType == 4 in bits 0..4
        // - +0x04: parent (RelativeDirectPointer)
        // - +0x08: numParams (UInt16 = 1), numRequirements (UInt16 = 1), numKeyArguments (UInt16 = 2), flags (UInt16)
        // - +0x10..+0x28: 1 GenericRequirementDescriptor (3 * Int32 = 12 bytes) + OpaqueType header
        // - +0x2c (index 11): RelativeDirectPointer<char> to the underlying type's symbolic mangled name:
        //     0x01/0x02 <rel32 to ModifiedContentVMn>
        //     0x79 ('y') 0x78 ('x')
        //     0x01 <rel32 to TextSelectionGroupModifierVMn>
        //     0x47 ('G') 0x00
        let words = qomq.assumingMemoryBound(to: Int32.self)
        let kind = UInt32(bitPattern: words[0]) & 0x1F
        guard kind == 4 else { return nil }

        let mangledOffset = Int(words[11])
        // The name is stored close to the descriptor; anything else is not a descriptor we know.
        guard mangledOffset != 0, abs(mangledOffset) < 1 << 20 else { return nil }
        let mangledPtr = qomq
            .advanced(by: 11 * MemoryLayout<Int32>.size)
            .advanced(by: mangledOffset)
            .assumingMemoryBound(to: UInt8.self)

        guard (mangledPtr[0] == 0x01 || mangledPtr[0] == 0x02),
              mangledPtr[5] == 0x79, // 'y'
              mangledPtr[6] == 0x78, // 'x'
              mangledPtr[7] == 0x01, // direct relative reference to nominal type descriptor
              mangledPtr[12] == 0x47 // 'G'
        else { return nil }

        let refAddr = UnsafeRawPointer(mangledPtr).advanced(by: 8)
        let rel = refAddr.loadUnaligned(as: Int32.self)
        let mnPtr = refAddr.advanced(by: Int(rel))
        let mnWords = mnPtr.assumingMemoryBound(to: Int32.self)

        // StructDescriptor has ContextDescriptorKind::Struct == 17 (0x11) in bits 0..4,
        // accessFunctionPtr at index 3 (+12), and numFields at index 5 (+20).
        let mnKind = UInt32(bitPattern: mnWords[0]) & 0x1F
        guard mnKind == 0x11,
              mnWords[5] == 0,
              mnWords[3] != 0
        else { return nil }

        let accessFnPtr = mnPtr
            .advanced(by: 3 * MemoryLayout<Int32>.size)
            .advanced(by: Int(mnWords[3]))
        typealias MetadataAccessFn = @convention(c) (Int) -> UnsafeRawPointer
        let accessFn = unsafeBitCast(accessFnPtr, to: MetadataAccessFn.self)
        let rawMeta = accessFn(0)
        let anyType = unsafeBitCast(rawMeta, to: Any.Type.self)
        guard let vmType = anyType as? any ViewModifier.Type,
              isZeroSizedWithNeverBody(vmType)
        else { return nil }
        return vmType
    }

    nonisolated private static func isZeroSizedWithNeverBody<M: ViewModifier>(_ type: M.Type) -> Bool {
        MemoryLayout<M>.size == 0 && M.Body.self == Never.self
    }
}

#if !os(watchOS) && !os(tvOS)
#Preview("TextSelectionGroup") {
    VStack(alignment: .leading, spacing: 12) {
        Text("First paragraph inside the selection group.")
        Text("Second paragraph — dragging across both selects and copies both.")
        Label("Disabled label (skipped when copying)", systemImage: "nosign")
            .textSelection(.disabled)
        Text("Third paragraph after the disabled label.")
    }
    .padding()
    .textSelectionGroup()
    .textSelection(.enabled)
}
#endif
