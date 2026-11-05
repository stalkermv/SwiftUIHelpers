// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIHelpers",
    platforms: [.iOS(.v17), .macOS(.v14), .macCatalyst(.v17), .tvOS(.v17), .watchOS(.v10)],
    products: [
        .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
        .library(name: "SwiftUIExtensions", targets: ["SwiftUIExtensions"]),
        .library(name: "SwiftUIHelpersUnsafe", targets: ["SwiftUIHelpersUnsafe"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stalkermv/SwiftHelpers.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftUIHelpers",
            dependencies: [
                "SwiftUIExtensions",
                .product(name: "SwiftHelpers", package: "SwiftHelpers"),
            ]
        ),
        .target(
            name: "SwiftUIExtensions",
            dependencies: [
                .product(name: "SwiftHelpers", package: "SwiftHelpers"),
            ]
        ),
        .target(name: "SwiftUIHelpersUnsafe"),
        .testTarget(
            name: "SwiftUIExtensionsTests",
            dependencies: ["SwiftUIExtensions"],
        ),
        .testTarget(
            name: "SwiftUIHelpersTests",
            dependencies: ["SwiftUIHelpers"],
        ),
    ]
)
