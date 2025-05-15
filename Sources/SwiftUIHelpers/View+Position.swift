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

private struct AnchorPointPositionModifier: ViewModifier {
    let unitPoint: UnitPoint
    let coordinateSpace: CoordinateSpace
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            let size = proxy.frame(in: coordinateSpace)
            
            let xOffset = (unitPoint.x - 0.5) * size.origin.x * 2
            let yOffset = (unitPoint.y - 0.5) * size.origin.y * 2
            
            let projectedPoint = CGPoint(
                x: xOffset + (size.width / 2),
                y: yOffset + (size.height / 2)
            )
            
            content.position(projectedPoint)
        }
    }
}
