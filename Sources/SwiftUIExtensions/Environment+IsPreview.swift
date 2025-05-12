//
//  Environment+IsPreview.swift
//  
//
//  Created by Valeriy Malishevskyi on 17.08.2023.
//

import SwiftUI
import FoundationExtensions

// MARK: - Environment Key for SwiftUI Preview Detection

public extension EnvironmentValues {
    /// Indicates if the current view is being rendered in a SwiftUI preview.
    var isPreview: Bool {
        get { self[IsPreviewEnvironmentKey.self] }
    }
}

private struct IsPreviewEnvironmentKey: EnvironmentKey {
    /// The default value is determined by `ProcessInfo.isPreview`.
    static let defaultValue: Bool = ProcessInfo.isPreview
}

// MARK: - View Extensions for Preview Detection

public extension View {
    /// Indicates if the view is being rendered in a SwiftUI preview.
    static var isPreview: Bool {
        ProcessInfo.isPreview
    }
}

// MARK: - Sample View for Testing Preview Detection

/// A view that displays whether it is currently in a SwiftUI preview or not.
struct Environment_IsPreview: View {
    var body: some View {
        VStack {
            Text("Is preview?")
                .font(.title)
            Text("\(Self.isPreview ? "Yes" : "No")")
        }
    }
}

#Preview {
    Environment_IsPreview()
}
