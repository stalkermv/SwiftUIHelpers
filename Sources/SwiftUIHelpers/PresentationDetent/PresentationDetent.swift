//
//  PresentationDetent.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 09.07.2025.
//

import SwiftUI

/// Use `PresentationDetent` to specify how a presented sheet should size itself relative to its content or the screen.
/// For example, you can use `.fit` to automatically adjust the sheet's height to fit its content, rather than using predefined heights.
///
/// - Note: This is designed to work with custom detent modifiers and is not the same as SwiftUI's built-in `PresentationDetent` type.
///
/// Example usage:
/// ```swift
/// .presentationDetent(.fit)
/// ```
public enum PresentationDetent {
    case fit
}

@available(iOS 16.0, *)
extension View {
    /// Applies a custom presentation detent to the view.
    ///
    /// Use this modifier to present a view with a custom detent, such as `.fit`,
    /// to automatically adjust the sheet's height to fit its content.
    ///
    /// - Parameter detent: The custom `PresentationDetent` to apply, such as `.fit`.
    /// - Returns: A view that presents using the specified detent.
    public func presentationDetent(_ detent: PresentationDetent) -> some View {
        modifier(FitPresentationDetentModifier())
    }
}

@available(iOS 16.0, *)
struct FitPresentationDetentModifier: ViewModifier {
    
    struct Geometry: Equatable {
        let frameHeight: CGFloat
        let safeAreaTop: CGFloat
    }
    
    @State private var height: CGFloat
    @State private var safeAreaTop: CGFloat = 0
    
    init(initial height: CGFloat = .infinity) {
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
                print("New height: \(newValue)")
                if abs(safeAreaTop - newValue.safeAreaTop) > 16, !newValue.safeAreaTop.isZero {
                    // When safe area changes significantly (e.g., during rotation), update immediately
                    safeAreaTop = newValue.safeAreaTop
                }
                DispatchQueue.main.async {
                    height = newValue.frameHeight
                }
            }
            .presentationDetents([.height(height + safeAreaTop)])
    }
}
