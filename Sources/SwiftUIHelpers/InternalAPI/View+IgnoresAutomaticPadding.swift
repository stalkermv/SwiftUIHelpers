//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension View {
    public func ignoresAutomaticPadding(_ flag: Bool = true) -> some View {
        self._ignoresAutomaticPadding(flag)
    }
}
