//
//  Created by Valeriy Malishevskyi on 28.08.2023.
//

import SwiftUI

@available(iOS 15.0, *)
@resultBuilder
public struct ShapeStyleBuilder {
    
    public static func buildBlock<S: ShapeStyle>(_ components: S...) -> some ShapeStyle {
        if let first = components.first {
            AnyShapeStyle(first)
        } else {
            AnyShapeStyle(BackgroundStyle())
        }
    }
    
    public static func buildEither<T: ShapeStyle>(first component: T) -> AnyShapeStyle {
        AnyShapeStyle(component)
    }
    
    public static func buildEither<F: ShapeStyle>(second component: F) -> AnyShapeStyle {
        AnyShapeStyle(component)
    }
}
