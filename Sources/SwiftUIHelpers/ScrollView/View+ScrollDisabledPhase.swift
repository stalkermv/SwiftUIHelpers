//
//  View+ScrollDisabledPhase.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 16.07.2026.
//

import SwiftUI

extension View {

    @available(iOS 18.0, *)
    public func scrollDisabled(_ disabled: Bool, during phase: ScrollPhase) -> some View {
        modifier(ScrollDisabledDuringPhase(disabled: disabled, phase: phase))
    }
}

@available(iOS 18.0, *)
struct ScrollDisabledDuringPhase: ViewModifier {
    let disabled: Bool
    let phase: ScrollPhase

    @State private var currentPhase: ScrollPhase = .idle

    func body(content: Content) -> some View {
        content
            .scrollDisabled(disabled && currentPhase == phase)
            .onScrollPhaseChange { oldPhase, newPhase in
                currentPhase = newPhase
            }
    }
}
