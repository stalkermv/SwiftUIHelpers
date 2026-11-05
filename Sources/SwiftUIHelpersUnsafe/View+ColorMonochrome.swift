//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension View {
    public func colorMonochrome(
        _ color: Color,
        amount: Double = 1,
        bias: Double = 0
    ) -> some View {
        self._colorMonochrome(color, amount: amount, bias: bias)
    }
}
