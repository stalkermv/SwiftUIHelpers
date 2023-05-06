//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import SwiftUI

public extension View {
    /// Embeds the view in a `NavigationView`.
    ///
    /// - Returns: A view embedded in a `NavigationView`.
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
