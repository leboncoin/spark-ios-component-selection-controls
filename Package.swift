// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "SparkSelectionControls",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SparkSelectionControls",
            targets: ["SparkSelectionControls"]
        ),
        .library(
            name: "SparkSelectionControlsTesting",
            targets: ["SparkSelectionControlsTesting"]
        )
    ],
    dependencies: [
       .package(
           url: "https://github.com/leboncoin/spark-ios-common.git",
           // path: "../spark-ios-common"
           /*version*/ "0.0.1"..."999.999.999"
       ),
       .package(
           url: "https://github.com/leboncoin/spark-ios-theming.git",
           // path: "../spark-ios-theming"
           /*version*/ "0.0.1"..."999.999.999"
       )
    ],
    targets: [
        .target(
            name: "SparkSelectionControls",
            dependencies: [
                .product(
                    name: "SparkCommon",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkTheming",
                    package: "spark-ios-theming"
                )
            ],
            path: "Sources/Core"
        ),
        .target(
            name: "SparkSelectionControlsTesting",
            dependencies: [
                "SparkSelectionControls",
                .product(
                    name: "SparkCommon",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkCommonTesting",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkThemingTesting",
                    package: "spark-ios-theming"
                ),
                .product(
                    name: "SparkTheme",
                    package: "spark-ios-theming"
                )
            ],
            path: "Sources/Testing"
        ),
        .testTarget(
            name: "SparkSelectionControlsUnitTests",
            dependencies: [
                "SparkSelectionControls",
                "SparkSelectionControlsTesting",
                .product(
                    name: "SparkCommonTesting",
                    package: "spark-ios-common"
                ),
                .product(
                    name: "SparkThemingTesting",
                    package: "spark-ios-theming"
                )
            ],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "SparkSelectionControlsSnapshotTests",
            dependencies: [
                "SparkSelectionControls",
                "SparkSelectionControlsTesting",
                .product(
                    name: "SparkCommonSnapshotTesting",
                    package: "spark-ios-common"
                ),
            ],
            path: "Tests/SnapshotTests"
        ),
    ]
)
