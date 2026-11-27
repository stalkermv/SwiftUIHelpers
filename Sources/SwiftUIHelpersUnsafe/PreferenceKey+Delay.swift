//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension PreferenceKey {
    public static func delay<T>(_ transform: @escaping (_PreferenceValue<Self>) -> T) -> some View where T : View {
        Self._delay(transform)
    }
}
