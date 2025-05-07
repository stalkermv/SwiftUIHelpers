//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension View {
    /// Add a background group, affecting the default background color.
    public func addingBackgroundGroup() -> some View {
        _addingBackgroundGroup()
    }
}


extension View {
    /// Add a background layer, affecting the default background color.
    public func addingBackgroundLayer() -> some View {
        _addingBackgroundLayer()
    }
}

extension View {
    /// Sets the style context of self to the default context.
    public func defaultContext() -> some View {
        _defaultContext()
    }
}
