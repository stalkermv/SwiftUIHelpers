//
//  Image+Resizable.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 11.07.2024.
//

import SwiftUI

extension Image {

    /// Returns a resizable image with the specified content mode.
    ///
    /// This method applies `.resizable()` to the image and then adjusts its aspect ratio
    /// according to the given `ContentMode` (`.fit` or `.fill`).
    ///
    /// ```swift
    /// Image("example")
    ///     .resizable(contentMode: .fit)
    ///     .frame(width: 100, height: 100)
    /// ```
    ///
    /// - Parameter contentMode: The desired scaling behavior for the image's aspect ratio.
    /// - Returns: A view that displays the image with the specified content mode and is resizable.
    public func resizable(contentMode: ContentMode) -> some View {
        self.resizable()
            .aspectRatio(contentMode: contentMode)
    }
}
