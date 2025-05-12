//
//  Scene+Modifier.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 13.12.2024.
//

import SwiftUI

extension Scene {
    public func modifier<M: _SceneModifier>(_ modifier: M) -> some Scene {
        ModifiedContent(content: self, modifier: modifier)
    }
}
