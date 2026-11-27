// FontProvider relies on UITraitCollection/UIFontMetrics, which watchOS does not have.
#if !os(watchOS)
//
//  NamedProvider.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

struct NamedProvider: FontProvider {
    var name: String
    var size: CGFloat
    var textStyle: PlatformTextStyle?

    func fontDescriptor(with traitCollection: PlatformTraitCollection?) -> PlatformFontDescriptor {
        let scaledSize: CGFloat
        if let textStyle = textStyle {
            #if canImport(UIKit)
            let metrics = UIFontMetrics(forTextStyle: textStyle)
            scaledSize = metrics.scaledValue(for: size, compatibleWith: traitCollection)
            #else
            scaledSize = size
            #endif
        } else {
            scaledSize = size
        }

        return PlatformFontDescriptor(fontAttributes: [
            .name: name,
            .size: scaledSize
        ])
    }
}
#endif
