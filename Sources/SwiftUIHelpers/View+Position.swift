//
//  View+Position.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 31.07.2024.
//

import SwiftUI

extension View {
    /// Positions the center of this view at a unit point of the space the view is offered.
    ///
    /// ```swift
    /// Badge()
    ///     .position(point: .topTrailing)
    /// ```
    ///
    /// - Parameter point: The unit point to place the view's center at, such as `.center`
    ///   or `.topLeading`.
    public func position(point: UnitPoint) -> some View {
        modifier(AnchorPointPositionModifier(unitPoint: point, coordinateSpace: .local))
    }

    /// Positions the center of this view at a unit point of the space the view is offered.
    ///
    /// The coordinate space does not change where the view lands: a unit point of the
    /// offered space is the same point whichever space measures it. Use
    /// ``position(point:)`` instead.
    ///
    /// - Parameters:
    ///   - point: The unit point to place the view's center at, such as `.center` or `.topLeading`.
    ///   - coordinateSpace: Ignored for placement; kept for source compatibility.
    @available(*, deprecated, renamed: "position(point:)", message: "The coordinate space does not change where the view lands.")
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
            let point = AnchorPointPositionModifier.localPoint(
                unitPoint: unitPoint,
                frame: frame,
                localSize: proxy.size
            )
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

    /// Converts a point expressed in the coordinate space that measured `frame` into the
    /// local coordinates of a view of `localSize` occupying that frame.
    ///
    /// `.position(_:)` expects parent-local coordinates, so the frame's origin is removed and
    /// any scale between the measured frame and the local size is undone.
    static func localPoint(_ point: CGPoint, in frame: CGRect, localSize: CGSize) -> CGPoint {
        let scaleX = frame.width == 0 ? 1 : localSize.width / frame.width
        let scaleY = frame.height == 0 ? 1 : localSize.height / frame.height
        return CGPoint(
            x: (point.x - frame.origin.x) * scaleX,
            y: (point.y - frame.origin.y) * scaleY
        )
    }

    /// Resolves `unitPoint` against `frame` and returns the result in local coordinates.
    static func localPoint(unitPoint: UnitPoint, frame: CGRect, localSize: CGSize) -> CGPoint {
        localPoint(projectedPoint(unitPoint: unitPoint, frame: frame), in: frame, localSize: localSize)
    }
}
