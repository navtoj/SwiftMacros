import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(SwiftMacrossPlugin)
	import SwiftMacrossPlugin

	let testMacros: [String: Macro.Type] = [
		"URL": URLMacro.self,
	]
#endif

// MARK: - SwiftMacrossTests

final class SwiftMacrossTests: XCTestCase {
	func testURLMacroWithStringLiteral() throws {
		#if canImport(SwiftMacrossPlugin)
			assertMacroExpansion(
				"""
				#URL("https://www.example.com")
				""",
				expandedSource: """
				Foundation.URL(string: "https://www.example.com")!
				""",
				macros: testMacros
			)
		#else
			throw XCTSkip("macros are only supported when running tests for the host platform")
		#endif
	}
}
