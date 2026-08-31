//
//  View+Position.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 31.07.2024.
//

import SwiftUI

extension View {
    public func position(
        point: UnitPoint,
        in coordinateSpace: CoordinateSpace
    ) -> some View {
        let modifier = AnchorPointPositionModifier(
            unitPoint: point,
            coordinateSpace: coordinateSpace
        )
        return self.modifier(modifier)
    }
}

struct AnchorPointPositionModifier: ViewModifier {
    let unitPoint: UnitPoint
    let coordinateSpace: CoordinateSpace

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: coordinateSpace)
            let point = AnchorPointPositionModifier.projectedPoint(unitPoint: unitPoint, frame: frame)
            content.position(point)
        }
    }

    /// Projects a `UnitPoint` onto an absolute `CGPoint` within `frame`.
    ///
    /// Formula: `(frame.origin.x + unitPoint.x * frame.width,
    ///            frame.origin.y + unitPoint.y * frame.height)`
    static func projectedPoint(unitPoint: UnitPoint, frame: CGRect) -> CGPoint {
        CGPoint(
            x: frame.origin.x + unitPoint.x * frame.width,
            y: frame.origin.y + unitPoint.y * frame.height
        )
    }
}
