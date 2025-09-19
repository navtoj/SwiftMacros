import Foundation

/// A macro that converts a static string literal into a URL instance at compile time. For example,
/// 	#URL("https://www.example.com")
/// produces a `URL` instance initialized with the provided string.
@freestanding(expression)
public macro URL(_ value: StaticString) -> URL = #externalMacro(module: "SwiftMacross", type: "URLMacro")
