//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

#if canImport(UIKit)
import SwiftUI

public extension View {
    
    /// Embeds the view in a `NavigationView`.
    ///
    /// - Returns: A view embedded in a `NavigationView`.
    @available(iOS 16.0, *)
    @ViewBuilder func embedInNavigation(titleDisplayMode: NavigationBarItem.TitleDisplayMode = .automatic) -> some View {
        NavigationStack { self.navigationBarTitleDisplayMode(titleDisplayMode) }
    }
}
#endif
