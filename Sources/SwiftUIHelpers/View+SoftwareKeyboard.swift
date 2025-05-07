//
//  Created by Valeriy Malishevskyi on 20.01.2024.
//

import SwiftUI

extension View {
    /// Modifies the view to trigger a software keyboard on appearance.
    ///
    /// This method is used to enforce the usage of the software keyboard instead of a hardware keyboard.
    /// It's particularly useful in scenarios where the app is running in an environment where both hardware
    /// and software keyboards are available, such as on iPad with an external keyboard connected.
    ///
    /// The method works by iterating over all active input modes (like different language keyboards)
    /// and sending a `setHardwareLayout:` message to each, instructing them to use the software layout.
    ///
    /// - Returns: A view that triggers the switch to a software keyboard when it appears.
    ///
    /// Usage:
    /// ```
    /// TextField("Hello, World!")
    ///     .softwareKeyboard() // Enforces software keyboard on this TextField view when it appears
    /// ```
    ///
    /// - Warning: This method uses private APIs (`NSSelectorFromString` and `setHardwareLayout:`) which
    ///   can lead to app rejection if used in apps submitted to the App Store. It's recommended to use this
    ///   for internal or testing purposes only.
    public func softwareKeyboard() -> some View {
        onAppear {
            let setHardwareLayout = NSSelectorFromString("setHardwareLayout:")
            
            UITextInputMode.activeInputModes
                .filter({ $0.responds(to: setHardwareLayout) })
                .forEach { $0.perform(setHardwareLayout, with: nil) }
        }
    }
}
