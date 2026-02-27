import Logging

public extension Logger {
    /// Logger dedicated to hierarchical palette resolution diagnostics.
    ///
    /// This logger is intentionally lightweight and does not bootstrap logging handlers.
    /// Applications should configure `LoggingSystem` at app startup.
    ///
    /// Note:
    /// Using a computed property avoids retaining an early pre-bootstrap logger instance
    /// in environments where previews initialize static storage before logging is configured.
    static var hierarchicalPalette: Logger {
        Logger(label: "com.swiftui-helpers.hierarchical-palette")
    }
}
