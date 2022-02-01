// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "litho-utils",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "litho-utils",
            targets: ["litho-utils"]),
    ],
    dependencies: [
        .package(name: "LithoOperators", url: "https://github.com/LithoByte/LithoOperators", branch: "master"),
        .package(name: "fuikit", url: "https://github.com/LithoByte/fuikit", branch: "master")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "litho-utils",
            dependencies: ["LithoOperators", "fuikit"],
            path: "Sources/LithoUtils/Classes/Base"
        ),
        .testTarget(
            name: "litho-utilsTests",
            dependencies: ["litho-utils"])
    ]
)
