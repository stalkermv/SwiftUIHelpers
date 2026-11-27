//
//  Environment+IsPreview.swift
//  
//
//  Created by Valeriy Malishevskyi on 17.08.2023.
//

import SwiftUI

// MARK: - Environment Key for SwiftUI Preview Detection

public extension EnvironmentValues {
    /// Indicates if the current view is being rendered in a SwiftUI preview.
    var isPreview: Bool {
        get { self[IsPreviewEnvironmentKey.self] }
    }
}

private struct IsPreviewEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool =
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}

// MARK: - View Extensions for Preview Detection

public extension View {
    /// Indicates if the view is being rendered in a SwiftUI preview.
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
