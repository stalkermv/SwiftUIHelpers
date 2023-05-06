//  MIT License
//
//  Copyright (c) 2023 Maksym Kuznietsov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import SwiftUI

public extension Binding where Value == Bool {
    /// Returns a closure that toggles the wrapped value when executed.
    ///
    /// - Returns: A closure that toggles the wrapped value.
    func toggleAction() -> () -> Void {
        return {
            self.wrappedValue.toggle()
        }
    }

    /// Returns a closure that toggles the wrapped value with the specified animation when executed.
    ///
    /// - Parameter animation: The animation to use when toggling the wrapped value.
    /// - Returns: A closure that toggles the wrapped value with the specified animation.
    func toggleAction(_ animation: Animation = .easeInOut) -> () -> Void {
        return {
            withAnimation(animation) {
                self.wrappedValue.toggle()
            }
        }
    }
}

public extension Binding {
    /// Creates a `Binding` with the specified value and action closure.
    ///
    /// - Parameters:
    ///   - value: The value to bind to.
    ///   - action: The closure to execute when the value is set.
    init(value: Value, action: @escaping () -> Void) {
        self.init(get: { value }, set: { _ in action() } )
    }

    /// Creates a `Binding` with the specified value and action closure.
    ///
    /// - Parameters:
    ///   - value: The value to bind to.
    ///   - action: The closure to execute when the value is set.
    init(value: Value, action: @escaping (Value) -> Void) {
        self.init(get: { value }, set: { action($0) } )
    }

    /// Creates a `Binding` with the specified getter and action closure.
    ///
    /// - Parameters:
    ///   - get: The closure to execute when getting the value.
    ///   - action: The closure to execute when the value is set.
    init(get: @escaping () -> Value, action: @escaping () -> Void) {
        self.init(get: get, set: { _ in action() })
    }

    /// Creates a `Binding` with the specified getter and action closure.
    ///
    /// - Parameters:
    ///   - get: The closure to execute when getting the value.
    ///   - action: The closure to execute when the value is set.
    init(get: @escaping () -> Value, action: @escaping (Value) -> Void) {
        self.init(get: get, set: { action($0) })
    }

    /// Creates a `Binding` with the specified read-only getter.
    ///
    /// - Parameters:
    ///   - get: The closure to execute when getting the value.
    init(readOnly get: @escaping () -> Value) {
        self.init(get: get, set: { _ in })
    }

    /// Creates a `Binding` with the specified value.
    ///
    /// - Parameter value: The value to bind to.
    init(value: Value) {
        self.init(get: { value }, set: { _ in })
    }
}
