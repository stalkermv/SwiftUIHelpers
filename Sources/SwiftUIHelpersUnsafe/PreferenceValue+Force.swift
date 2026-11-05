//
//  Created by Valeriy Malishevskyi on 06.05.2024.
//

import SwiftUI

extension _PreferenceValue where Key: PreferenceKey {
    public func force<T>(_ transform: @escaping (Key.Value) -> T) -> _PreferenceReadingView<Key, T> where T : View {
        self._force(transform)
    }
}
