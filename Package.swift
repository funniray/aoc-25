// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC25",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/ordo-one/package-benchmark", .upToNextMajor(from: "1.4.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "AOC25"),
        .testTarget(
            name: "AOC25-test",
            dependencies: ["AOC25"],
            path: "Tests"
        ),
        .executableTarget(
            name: "AOC25-cli",
            dependencies: ["AOC25"],
            resources: [
                .embedInCode("../../Inputs/day-1.txt"),
                .embedInCode("../../Inputs/day-2.txt"),
                .embedInCode("../../Inputs/day-3.txt"),
                .embedInCode("../../Inputs/day-4.txt"),
                .embedInCode("../../Inputs/day-5.txt")
            ]),
    ]
)

// Benchmark of AOC25-bench
package.targets += [
    .executableTarget(
        name: "AOC25-bench",
        dependencies: [
            .product(name: "Benchmark", package: "package-benchmark"),
            "AOC25"
        ],
        path: "Benchmarks/AOC25-bench",
        resources: [
            .embedInCode("../../Inputs/day-1.txt"),
            .embedInCode("../../Inputs/day-2.txt"),
            .embedInCode("../../Inputs/day-3.txt"),
            .embedInCode("../../Inputs/day-4.txt"),
            .embedInCode("../../Inputs/day-5.txt")
        ],
        plugins: [
            .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
        ]
    ),
]
