// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "RxDratini",
    dependencies: [
        .Package(url: "https://github.com/kevin0571/Dratini.git", majorVersion: 1),
        .Package(url: "https://github.com/ReactiveX/RxSwift.git", majorVersion: 3)
    ]
)
