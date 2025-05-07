//
//  Created by Valeriy Malishevskyi on 22.02.2024.
//

import SwiftUI

public extension View {
    /// Provides a modifier for applying custom geometry effects to a view.
    ///
    /// Use this modifier to add dynamic effects to a view based on its geometry, such as position and size. 
    /// Ideal for creating animations or visual transformations that respond to changes in the view's environment.
    ///
    /// - Parameter effect: A closure that defines the custom effect, taking the current view and its geometry proxy as arguments, and returning a modified view.
    /// - Returns: A view modified by the specified geometry effect.
    @_disfavoredOverload
    func geometryEffect(@ViewBuilder _ effect: @escaping @MainActor (Self, GeometryEffectProxy) -> some View) -> some View {
        GeometryEffectView(root: self, content: effect)
    }
}
