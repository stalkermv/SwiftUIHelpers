//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension View {
    
    /// Applies explicit padding to a view that allows being disabled by that view using `ignoresAutomaticPadding`.
    /// - Parameter insets: The amount to inset this view on each edge.
    /// - Returns: A view that insets this view by the amount specified in
    public func automaticPadding(_ insets: EdgeInsets) -> some View {
        self._automaticPadding(insets)
    }
    
    /// Applies explicit padding to a view that allows being disabled by that view using `ignoresAutomaticPadding`.
    /// - Parameters:
    ///  - edge: The edge to apply padding to.
    ///  - length: The amount to inset this view on the specified edge.
    ///  - Returns: A view that insets this view by the amount specified
    public func automaticPadding(_ edge: Edge.Set, _ length: CGFloat = 16) -> some View {
        let edgeInsets = EdgeInsets(
            top: edge.contains(.top) ? length : 0,
            leading: edge.contains(.leading) ? length : 0,
            bottom: edge.contains(.bottom) ? length : 0,
            trailing: edge.contains(.trailing) ? length : 0
        )
        
        return self.automaticPadding(edgeInsets)
    }
}
