//
//  FontModifier.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import UIKit

protocol FontModifier {
    func modify(_ fontDescriptor: inout UIFontDescriptor)
}
