//
//  DynamicTypeSize+ContentSizeCategory.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI

extension ContentSizeCategory {
    
    /// Initializes a `ContentSizeCategory` from a corresponding `DynamicTypeSize` value.
    ///
    /// This initializer provides a mapping between SwiftUI's `DynamicTypeSize` and UIKit's
    /// `UIContentSizeCategory`, allowing interoperability between the two APIs.
    /// It covers all standard and accessibility sizes, and defaults to `.medium` for any unknown cases.
    ///
    /// ```swift
    /// let contentSize = ContentSizeCategory(.large)
    /// print(contentSize) // .large
    /// ```
    ///
    /// - Parameter dynamicTypeSize: The `DynamicTypeSize` to convert.
    public init(_ dynamicTypeSize: DynamicTypeSize) {
        switch dynamicTypeSize {
        case .xSmall:
            self = .extraSmall
        case .small:
            self = .small
        case .medium:
            self = .medium
        case .large:
            self = .large
        case .xLarge:
            self = .extraLarge
        case .xxLarge:
            self = .extraExtraLarge
        case .xxxLarge:
            self = .extraExtraExtraLarge
        case .accessibility1:
            self = .accessibilityMedium
        case .accessibility2:
            self = .accessibilityLarge
        case .accessibility3:
            self = .accessibilityExtraLarge
        case .accessibility4:
            self = .accessibilityExtraExtraLarge
        case .accessibility5:
            self = .accessibilityExtraExtraExtraLarge
        default:
            self = .medium
        }
    }
}
