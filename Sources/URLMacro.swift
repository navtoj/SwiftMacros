import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - URLMacro

public struct URLMacro: ExpressionMacro {
	public static func expansion(
		of node: some FreestandingMacroExpansionSyntax,
		in _: some MacroExpansionContext
	) throws -> ExprSyntax {
		// Verify that a string literal was passed, and extract
		// the first segment. We can be sure that only one
		// segment exists, since we're only accepting static
		// strings (which cannot have any dynamic components):
		guard let argument = node.arguments.first?.expression,
		      let literal = argument.as(StringLiteralExprSyntax.self),
		      case let .stringSegment(segment) = literal.segments.first else
		{
			throw URLMacroError.notAStringLiteral
		}

		// Verify that the passed string is indeed a valid URL:
		guard URL(string: segment.content.text) != nil else {
			throw URLMacroError.invalidURL
		}

		// Generate the code required to construct a URL value
		// for the passed string at runtime:
		return "Foundation.URL(string: \(argument))!"
	}
}

// MARK: - URLMacroError

enum URLMacroError: String, Error, CustomStringConvertible {
	case notAStringLiteral = "Argument is not a string literal"
	case invalidURL = "Argument is not a valid URL"

	// MARK: Computed Properties

	var description: String { rawValue }
}

// https://www.swiftbysundell.com/articles/modern-url-construction-in-swift
