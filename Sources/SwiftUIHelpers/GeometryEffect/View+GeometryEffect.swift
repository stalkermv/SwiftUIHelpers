//
//  Created by Valeriy Malishevskyi on 22.02.2024.
//

import SwiftUI

public extension View {
    /// Applies a custom geometry effect layer to a view.
    ///
    /// Use this modifier to add dynamic effects based on the view's geometry,
    /// such as position and size. Ideal for animations or visual transformations
    /// that respond to changes in the view's environment.
    ///
    /// - Parameter effect: A closure that takes the current view and its
    ///   `GeometryEffectProxy` and returns a modified view.
    /// - Returns: A view modified by the specified geometry effect.
    func geometryEffectLayer(@ViewBuilder _ effect: @escaping @MainActor (Self, GeometryEffectProxy) -> some View) -> some View {
        GeometryEffectView(root: self, content: effect)
    }
}
