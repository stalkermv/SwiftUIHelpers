//
//  Created by Valeriy Malishevskyi on 15.03.2024.
//

import Foundation

public protocol Previewable {
    static var preview: Self { get }
    static func preview(count: Int) -> [Self]
    static func makePreview(idx: Int) -> Self
}

extension Previewable {
    public static var preview: Self {
        makePreview(idx: 0)
    }
    
    public static func preview(count: Int) -> [Self] {
        (0..<count).map { makePreview(idx: $0) }
    }
}

extension Array where Element: Previewable {
    public static var preview: [Element] {
        Element.preview(count: 3)
    }
    
    public static func preview(count: Int) -> [Element] {
        Element.preview(count: count)
    }
}
