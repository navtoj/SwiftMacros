import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SwiftMacrossPlugin: CompilerPlugin {
	let providingMacros: [Macro.Type] = [
		URLMacro.self,
	]
}
