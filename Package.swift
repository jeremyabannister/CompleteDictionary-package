// swift-tools-version: 5.10

///
import PackageDescription


///
let package = Package(
    name: "CompleteDictionary-module",
    products: [
        .library(
            name: "CompleteDictionary-module",
            targets: ["CompleteDictionary-module"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/jeremyabannister/FoundationToolkit",
            "0.8.0" ..< "0.9.0"
        ),
    ],
    targets: [
        .target(
            name: "CompleteDictionary-module",
            dependencies: [
                "FoundationToolkit",
            ]
        ),
        .testTarget(
            name: "CompleteDictionary-module-tests",
            dependencies: [
                "CompleteDictionary-module",
                .product(
                    name: "FoundationTestToolkit",
                    package: "FoundationToolkit"
                ),
            ]
        ),
    ]
)
