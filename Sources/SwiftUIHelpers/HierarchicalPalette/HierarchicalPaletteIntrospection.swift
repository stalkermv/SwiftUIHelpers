import SwiftUI

enum HierarchicalPaletteOperationKind: String, Sendable {
    case primaryStyle
    case resolveStyle
    case prepareText
    case copyStyleForeground
    case copyStyleOther
    case unknown
}

struct HierarchicalPaletteOperationInfo: Sendable {
    let kind: HierarchicalPaletteOperationKind
    let raw: String
    let level: Int?
    let levelSource: String
}

enum HierarchicalPaletteIntrospection {
    static func environment(from shape: Any) -> EnvironmentValues? {
        child(named: "environment", in: shape) as? EnvironmentValues
    }

    static func operationInfo(from shape: Any) -> HierarchicalPaletteOperationInfo {
        guard let operation = child(named: "operation", in: shape) else {
            return .init(kind: .unknown, raw: "missing", level: nil, levelSource: "missing.operation")
        }

        let raw = String(describing: operation)
        let kind = classifyOperation(raw: raw)

        if let level = resolveStyleLevel(from: operation) {
            return .init(kind: kind, raw: raw, level: level, levelSource: "resolveStyle.lowerBound")
        }

        if let level = parseLevel(after: "prepareText(level: ", in: raw) {
            return .init(kind: kind, raw: raw, level: level, levelSource: "prepareText.level")
        }

        if let level = parseLevel(after: "level: ", in: raw) {
            return .init(kind: kind, raw: raw, level: level, levelSource: "operation.level")
        }

        return .init(kind: kind, raw: raw, level: nil, levelSource: "none")
    }

    static func role(from shape: Any) -> String {
        if let role = child(named: "role", in: shape) {
            return String(describing: role)
        }

        return "unknown"
    }

    static func substrate(from shape: Any) -> String {
        if let substrate = child(named: "substrate", in: shape) {
            return String(describing: substrate)
        }

        return "unknown"
    }

    static func child(named label: String, in value: Any) -> Any? {
        Mirror(reflecting: value).children.first { $0.label == label }?.value
    }

    private static func classifyOperation(raw: String) -> HierarchicalPaletteOperationKind {
        if raw.contains("resolveStyle") { return .resolveStyle }
        if raw.contains("prepareText") { return .prepareText }

        if raw.contains("copyStyle(name:") {
            if raw.contains("_ShapeStyle_Name.foreground") || raw.contains("name: foreground") {
                return .copyStyleForeground
            }
            return .copyStyleOther
        }

        if raw == "primaryStyle" { return .primaryStyle }
        return .unknown
    }

    private static func resolveStyleLevel(from operation: Any) -> Int? {
        guard
            let resolveStyle = child(named: "resolveStyle", in: operation),
            let levels = child(named: "levels", in: resolveStyle),
            let lowerBound = child(named: "lowerBound", in: levels) as? Int
        else {
            return nil
        }

        return lowerBound
    }

    private static func parseLevel(after token: String, in raw: String) -> Int? {
        guard let range = raw.range(of: token) else { return nil }

        let suffix = raw[range.upperBound...]
        let digits = suffix.prefix { $0.isNumber || $0 == "-" }
        guard !digits.isEmpty else { return nil }

        return Int(digits)
    }

}
