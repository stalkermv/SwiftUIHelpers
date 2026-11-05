//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

/// A view that instantiates a child content view, “detaching” some of its inherited attributes,
/// then constructs a new child view hierarchy as a function of a placeholder representing the detached view.
/// Typically used to restrict where preference values are read from to avoid evaluation cycles.
public struct DetachedView<Detached, Content, Child> where Detached : _Detachable, Content : View, Child : View {
    let content: Content
    let transform: (_DetachedPlaceholder<Detached>) -> Child
    
    public init(content: Content, transform: @escaping (_DetachedPlaceholder<Detached>) -> Child) {
        self.content = content
        self.transform = transform
    }
}

extension DetachedView: View {
    public var body: some View {
        _DetachedView(content: content, transform: transform)
    }
}
