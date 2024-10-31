// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KHBusinessLogic",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "KHBusinessLogic",
            targets: ["KHBusinessLogic"]),
    ],
    dependencies: [
        .package(path: "./../kh-content/Packages/KHContentSource"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "KHBusinessLogic",
            dependencies: [
                "KHContentSource"
            ]
        ),
        .testTarget(
            name: "KHBusinessLogicTests",
            dependencies: ["KHBusinessLogic"]
        ),
    ]
)
