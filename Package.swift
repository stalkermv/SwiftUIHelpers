// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIHelpers",
    platforms: [.iOS(.v15), .macOS(.v13), .tvOS(.v15), .watchOS(.v8)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftUIHelpers",
            dependencies: [
                "SwiftUIExtensions",
            ]
        ),
        .target(
            name: "SwiftUIExtensions",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftUIExtensionsTests",
            dependencies: ["SwiftUIExtensions"],
        ),
    ]
)
