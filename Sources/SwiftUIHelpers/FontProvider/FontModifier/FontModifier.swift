//
//  FontModifier.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 12.07.2024.
//

import SwiftUI

protocol FontModifier {
    func modify(_ fontDescriptor: inout PlatformFontDescriptor)
}
