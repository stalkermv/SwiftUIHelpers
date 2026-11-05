//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension EnvironmentValues {
    public var lineHeightMultiple: CGFloat {
        get {
            self._lineHeightMultiple
        }
        set {
            self._lineHeightMultiple = newValue
        }
    }
}
