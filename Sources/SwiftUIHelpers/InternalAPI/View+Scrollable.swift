//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension View {
    public func scrollable(
        stretchChildrenToMaxHeight: Bool = false,
        horizontal: TextAlignment? = .center,
        vertical: _VAlignment? = .center
    ) -> _ScrollView<_AligningContentProvider<some View>> {
        _scrollable(
            stretchChildrenToMaxHeight: stretchChildrenToMaxHeight,
            horizontal: horizontal,
            vertical: vertical
        )
    }
}
