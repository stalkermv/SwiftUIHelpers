//
//  UIColor+HexContainer.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 05.08.2024.
//

import SwiftUI
import SwiftHelpers

extension UIColor {
    public convenience init(_ container: HexColorContainer) {
        self.init(red: container.red, green: container.green, blue: container.blue, alpha: CGFloat(1.0))
    }
}
