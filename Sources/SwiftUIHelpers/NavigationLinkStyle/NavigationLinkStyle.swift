//
//  NavigationLinkStyle.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 06.08.2024.
//

import SwiftUI

public protocol NavigationLinkStyle: ButtonStyle { }

extension View {
    public func navigationLinkStyle(_ style: some NavigationLinkStyle) -> some View {
        buttonStyle(style)
    }
}
