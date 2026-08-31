//
//  UIFont.Weight+Font.Weight.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

#if canImport(UIKit)
import SwiftUI

extension UIFont.Weight {
    public init(_ weight: Font.Weight) {
        switch weight {
        case .ultraLight:
            self = .ultraLight
        case .thin:
            self = .thin
        case .light:
            self = .light
        case .regular:
            self = .regular
        case .medium:
            self = .medium
        case .semibold:
            self = .semibold
        case .bold:
            self = .bold
        case .heavy:
            self = .heavy
        case .black:
            self = .black
        @unknown default:
            self = .regular
        }
    }
}
#endif
