//
//  SelectableArrayPageMetadata.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 28.09.2024.
//

import SwiftUI

public struct SelectableArrayPageMetadata: Equatable {
    public var index: Int
    public var count: Int
}

extension FormatStyle where Self == SelectableArrayPageMetadata.FormatStyle {
    public static var pageMetadata: SelectableArrayPageMetadata.FormatStyle {
        .init()
    }
}

extension SelectableArray where Element: Identifiable {
    @MainActor public var pageMetadata: SelectableArrayPageMetadata {
        .init(index: selectionIndex ?? 0, count: count)
    }
}

extension SelectableArrayPageMetadata {
    public struct FormatStyle: SwiftUI.FormatStyle {
        public typealias FormatInput = SelectableArrayPageMetadata
        public typealias FormatOutput = String
        
        public func format(_ value: FormatInput) -> FormatOutput {
            "\(value.index + 1) / \(value.count)"
        }
    }
}
