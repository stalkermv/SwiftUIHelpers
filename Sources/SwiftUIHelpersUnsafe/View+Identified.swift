//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension View {
    public func identified<I>(by identifier: I) -> some View where I : Hashable {
        self._identified(by: identifier)
    }
}
