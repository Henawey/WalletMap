// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MindMap",
    platforms: [
        .macOS(.v10_14), .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "MindMap",
            targets: ["MindMap"]
        ),
    ],
    targets: [
        .target(
            name: "MindMap"),
        .testTarget(
            name: "MindMapTests",
            dependencies: ["MindMap"]),
    ]
)
