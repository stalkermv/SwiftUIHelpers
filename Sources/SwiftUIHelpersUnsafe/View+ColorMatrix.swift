//
//  Created by Valeriy Malishevskyi on 05.11.2026.
//

import SwiftUI

extension View {
    /// Applies a 4x5 color matrix to the view.
    ///
    /// Wraps the underscored SwiftUI API `_colorMatrix(_:)`. Not covered by semver.
    public func colorMatrix(_ matrix: _ColorMatrix) -> some View {
        _colorMatrix(matrix)
    }
}
