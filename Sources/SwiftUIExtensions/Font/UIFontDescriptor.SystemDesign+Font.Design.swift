//
//  UIFontDescriptor.SystemDesign+Font.Design.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI

extension UIFontDescriptor.SystemDesign {
    public init(_ design: Font.Design) {
        switch design {
        case .default:
            self = .default
        case .serif:
            self = .serif
        case .rounded:
            self = .rounded
        case .monospaced:
            self = .monospaced
        default:
            self = .default
        }
    }
}
