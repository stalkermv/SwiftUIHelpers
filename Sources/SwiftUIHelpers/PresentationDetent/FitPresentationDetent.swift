//
//  FitPresentationDetent.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 09.07.2025.
//

import SwiftUI
#if os(watchOS)
import WatchKit
#endif

/// Specifies how a presented sheet should size itself relative to its content.
///
/// Use `.fit` to automatically adjust the sheet height to its content, rather
/// than using predefined heights.
///
/// The type has its own name so that it does not clash with SwiftUI's
/// `PresentationDetent` when both modules are imported. At the call site you only
/// write `.fit`:
///
/// ```swift
/// .sheet(isPresented: $show) {
///     ContentView()
///         .presentationDetent(.fit)
/// }
/// ```
///
/// SwiftUI's own `presentationDetents(_:)` (plural) is a different modifier and
/// can be used in the same file.
public enum FitPresentationDetent {
    case fit
}

extension View {
    /// Applies a custom presentation detent to the view.
    ///
    /// Use this modifier with `.fit` to size the sheet to its content.
    ///
    /// - Parameter detent: The detent to apply, `.fit`.
    /// - Returns: A view that presents using a height-fitting detent.
    public func presentationDetent(_ detent: FitPresentationDetent) -> some View {
        modifier(FitPresentationDetentModifier())
    }
}

struct FitPresentationDetentModifier: ViewModifier {

    struct Geometry: Equatable {
        let frameHeight: CGFloat
        let safeAreaTop: CGFloat
    }

    @State private var height: CGFloat
    @State private var trackedSafeAreaTop: CGFloat = 0

    init(initial height: CGFloat = {
        #if os(watchOS)
        return WKInterfaceDevice.current().screenBounds.height / 2
        #elseif canImport(UIKit)
        return UIScreen.main.bounds.height / 2
        #else
        return (NSScreen.main?.visibleFrame.height ?? 400) / 2
        #endif
    }()) {
        self._height = .init(initialValue: height)
    }

    func body(content: Content) -> some View {
        content
            .onGeometryChange(for: Geometry.self) { proxy in
                Geometry(
                    frameHeight: proxy.frame(in: .global).height.rounded(.up),
                    safeAreaTop: proxy.safeAreaInsets.top.rounded(.up)
                )
            } action: { newValue in
                let result = FitPresentationDetentModifier.resolvedDetentHeight(
                    frameHeight: newValue.frameHeight,
                    safeAreaTop: newValue.safeAreaTop,
                    trackedSafeAreaTop: trackedSafeAreaTop
                )
                height = result.height
                trackedSafeAreaTop = result.safeAreaTop
            }
            .presentationDetents([.height(height)])
    }

    /// Computes the resolved detent height, resetting the stuck-inset when needed.
    ///
    /// The safe-area tracking resets when:
    /// - `abs(new - tracked) > 16` (significant jump, e.g. rotation), OR
    /// - `tracked != 0 AND new == 0` (inset disappeared entirely)
    ///
    /// - Returns: `(height, safeAreaTop)` where height already includes the top inset.
    static func resolvedDetentHeight(
        frameHeight: CGFloat,
        safeAreaTop: CGFloat,
        trackedSafeAreaTop: CGFloat
    ) -> (height: CGFloat, safeAreaTop: CGFloat) {
        let shouldReset = abs(safeAreaTop - trackedSafeAreaTop) > 16
            || (trackedSafeAreaTop != 0 && safeAreaTop == 0)
        let newTracked = shouldReset ? safeAreaTop : trackedSafeAreaTop
        return (height: frameHeight + safeAreaTop, safeAreaTop: newTracked)
    }
}
