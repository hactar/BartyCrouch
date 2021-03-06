import Foundation
import Toml

struct InterfacesOptions {
    let paths: [String]
    let defaultToBase: Bool
    let ignoreEmptyStrings: Bool
    let unstripped: Bool
}

extension InterfacesOptions: TomlCodable {
    static func make(toml: Toml) throws -> InterfacesOptions {
        let update: String = "update"
        let interfaces: String = "interfaces"

        return InterfacesOptions(
            paths: toml.filePaths(update, interfaces, singularKey: "path", pluralKey: "paths"),
            defaultToBase: toml.bool(update, interfaces, "defaultToBase") ?? false,
            ignoreEmptyStrings: toml.bool(update, interfaces, "ignoreEmptyStrings") ?? false,
            unstripped: toml.bool(update, interfaces, "unstripped") ?? false
        )
    }

    func tomlContents() -> String {
        var lines: [String] = ["[update.interfaces]"]

        lines.append("paths = \(paths)")
        lines.append("defaultToBase = \(defaultToBase)")
        lines.append("ignoreEmptyStrings = \(ignoreEmptyStrings)")
        lines.append("unstripped = \(unstripped)")

        return lines.joined(separator: "\n")
    }
}
