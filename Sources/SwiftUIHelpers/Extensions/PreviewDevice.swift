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

public extension PreviewDevice {
    static let iPhoneSE: PreviewDevice = .init(rawValue: "iPhone SE (1st generation)")
    static let iPhoneSE2: PreviewDevice = .init(rawValue: "iPhone SE (2nd generation)")
    static let iPhone8: PreviewDevice = .init(rawValue: "iPhone 8")
    static let iPhone8Plus: PreviewDevice = .init(rawValue: "iPhone 8 Plus")
    static let iPhone11: PreviewDevice = .init(rawValue: "iPhone 11")
    static let iPhone11Pro: PreviewDevice = .init(rawValue: "iPhone 11 Pro")
    static let iPhone11ProMax: PreviewDevice = .init(rawValue: "iPhone 11 Pro Max")
}

// MARK: - PreviewOnDevices

public extension PreviewDevice {
    /// Returns a `Group` of views with the specified view wrapped in a `ForEach` loop for each device in the specified array, previewing the view on each device.
    ///
    /// - Parameters:
    ///   - devices: An array of `PreviewDevice` values to preview the view on. Defaults to all available devices.
    ///   - contentBuilder: A closure returning the view to preview on each device.
    ///
    /// - Returns: A `Group` of views previewing the specified view on each device.
    static func previewOnDevices<V: View>(_ devices: [PreviewDevice] = PreviewDevice.allCases, @ViewBuilder contentBuilder: @escaping () -> V) -> some View {
        Group {
            ForEach(devices) {
                contentBuilder()
                    .previewDevice($0)
                    .previewDisplayName($0.rawValue)
            }
        }
    }
}

// MARK: - Identifiable
extension PreviewDevice: Identifiable {
    public var id: String { rawValue }
}

// MARK: - CaseIterable
extension PreviewDevice: CaseIterable {
    public static var allCases: [PreviewDevice] = [.iPhone11ProMax, .iPhone11Pro, .iPhone11, .iPhone8Plus, .iPhone8, .iPhoneSE]
}
