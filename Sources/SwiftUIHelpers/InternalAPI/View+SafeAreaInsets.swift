//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension View {
    public func safeAreaInsets(_ insets: EdgeInsets) -> some View {
        _safeAreaInsets(insets)
    }
    
    public func safeAreaInsets(_ edges: Edge.Set = .all, _ length: CGFloat) -> some View {
        let edgeInsets = EdgeInsets(
            top: edges.contains(.top) ? length : 0,
            leading: edges.contains(.leading) ? length : 0,
            bottom: edges.contains(.bottom) ? length : 0,
            trailing: edges.contains(.trailing) ? length : 0
        )
        return safeAreaInsets(edgeInsets)
    }
}
