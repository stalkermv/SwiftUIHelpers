//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension Text {
    public func stylisticAlternative(_ alternative: Font._StylisticAlternative) -> some View {
        self._stylisticAlternative(alternative)
    }
}
