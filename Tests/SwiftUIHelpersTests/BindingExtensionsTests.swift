//
//  BindingExtensionsTests.swift
//  
//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import XCTest
import SwiftUIHelpers

final class BindingExtensionsTests: XCTestCase {

    func testToggleAction() {
        var boolValue = true
        let binding = Binding<Bool>(
            get: { boolValue },
            set: { boolValue = $0 }
        )
        
        let toggleAction = binding.toggleAction()
        
        toggleAction()
        XCTAssertEqual(boolValue, false)
        
        toggleAction()
        XCTAssertEqual(boolValue, true)
    }

}
