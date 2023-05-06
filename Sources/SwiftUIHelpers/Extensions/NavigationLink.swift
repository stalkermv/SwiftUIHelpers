//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import SwiftUI

public extension NavigationLink where Label == EmptyView {
    /// Creates a `NavigationLink` with an empty label and the specified destination and binding to its `isActive` state.
    ///
    /// - Parameters:
    ///   - destination: The destination view of the link.
    ///   - isActive: A binding to the `isActive` state of the link.
    init(destination: Destination, isActive: Binding<Bool>) {
        self.init(destination: destination, isActive: isActive) { EmptyView() }
    }

    /// Creates a `NavigationLink` with an empty label and the specified closure to construct its destination
    /// and binding to its `isActive` state.
    ///
    /// - Parameters:
    ///   - isActive: A binding to the `isActive` state of the link.
    ///   - destination: A closure returning the destination view of the link.
    init(isActive: Binding<Bool>, @ViewBuilder destination: @escaping () -> Destination) {
        self.init(destination: destination(), isActive: isActive) { EmptyView() }
    }
}
