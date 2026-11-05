//
//  Created by Valeriy Malishevskyi on 05.11.2026.
//

import SwiftUI

extension ShapeStyle {
    /// A view that fills the current container shape with this style.
    ///
    /// Wraps the underscored SwiftUI API `_fillingContainerShape()`. Not covered by semver.
    public func fillingContainerShape() -> some View {
        _fillingContainerShape()
    }
}
