// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
	name: "SwiftMacros",
	platforms: [
		.macOS(.v15),
	],
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.library(
			name: "SwiftMacros",
			targets: ["SwiftMacros"]
		),
	],
	dependencies: [
		.package(
			url: "https://github.com/swiftlang/swift-syntax.git",
			from: "602.0.0"
		),
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		// Macro implementation that performs the source transformation of a macro.
		.macro(
			name: "SwiftMacrosPlugin",
			dependencies: [
				.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
				.product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
			],
			path: "Sources"
		),

		// Library that exposes a macro as part of its API, which is used in client programs.
		.target(
			name: "SwiftMacros",
			dependencies: ["SwiftMacrosPlugin"],
			path: ".",
			sources: ["SwiftMacros.swift"]
		),

		// A test target used to develop the macro implementation.
		.testTarget(
			name: "SwiftMacrosTests",
			dependencies: [
				"SwiftMacrosPlugin",
				.product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
			],
			path: ".",
			sources: ["SwiftMacrosTests.swift"]
		),
	]
)
