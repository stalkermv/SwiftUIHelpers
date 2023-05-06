//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import SwiftUI

public extension UIColor {
    /// Creates a `UIColor` instance with the specified red, green, and blue values.
    ///
    /// - Parameters:
    ///   - red: The red component of the color, from 0 to 255.
    ///   - green: The green component of the color, from 0 to 255.
    ///   - blue: The blue component of the color, from 0 to 255.
    ///
    /// - Returns: A `UIColor` instance with the specified RGB values.
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    /// Creates a `UIColor` instance with the specified RGB value.
    ///
    /// - Parameter rgb: The RGB value of the color, in hexadecimal format.
    ///
    /// - Returns: A `UIColor` instance with the specified RGB value.
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    /// Creates a `UIColor` instance with the specified hexadecimal value.
    ///
    /// - Parameter hex: The hexadecimal value of the color.
    ///
    /// - Returns: A `UIColor` instance with the specified hexadecimal value.
    convenience init?(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return nil
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public extension UIColor {
    /// Creates a `UIColor` instance that adapts to the current interface style (light or dark) by returning the appropriate color.
    ///
    /// - Parameters:
    ///   - light: The color to use in light mode.
    ///   - dark: The color to use in dark mode.
    ///
    /// - Returns: A `UIColor` instance that adapts to the current interface style.
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return light
            case .dark:
                return dark
            @unknown default:
                return light
            }
        }
    }
}
