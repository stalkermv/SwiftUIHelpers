//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

public typealias EmptyDetached = _EmptyDetached

/// An opaque placeholder for a detached view, the placeholder may be used as a child of one other view.
public struct DetachedPlaceholder<Detached> where Detached : _Detachable {
    let detached: Detached
}

extension View {
    public func detached<T, U>(
        with type: T.Type = T.self,
        _ transform: @escaping (_DetachedPlaceholder<T>) -> U
    ) -> some View where T : _Detachable, U : View {
        _detached(with: type, transform)
    }
}
