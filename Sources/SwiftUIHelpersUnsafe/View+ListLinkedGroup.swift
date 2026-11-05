//
//  Created by Valeriy Malishevskyi on 05.11.2026.
//

import SwiftUI

#if os(watchOS)
extension View {
    /// Visually links this list row with its neighbours (watchOS only).
    ///
    /// Wraps the underscored SwiftUI API `_listLinkedGroup(_:)`. Not covered by semver.
    @available(iOS, unavailable)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    public func listLinkedGroup(_ isLinked: Bool) -> some View {
        _listLinkedGroup(isLinked)
    }
}
#endif
