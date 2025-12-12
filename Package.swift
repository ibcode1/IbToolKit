// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IbToolKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "IbFoundation",
                 targets: ["IbFoundation"]),
        .library(
            name: "IbToolKit",
            targets: ["IbToolKit"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "IbFoundation"
        ),
        .testTarget(
            name: "IbFoundationTests",
            dependencies: ["IbFoundation"]),

        .target(
            name: "IbToolKit",
            dependencies: ["IbFoundation"],
            resources: [.process("Resources")]
        ),
        
        .testTarget(
            name: "IbToolKitTests",
            dependencies: [
                "IbToolKit",
                "IbFoundation"
            ]
        ),
    ]
)
