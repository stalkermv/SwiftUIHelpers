//
//  Color+Random.swift
//  
//
//  Created by Valeriy Malishevskyi on 31.07.2023.
//

import SwiftUI

extension Color {
    /// Returns a random color with RGB values between 0 and 1.
    ///
    /// - Returns: A random color.
    public static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
