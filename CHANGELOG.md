# Changelog

All notable changes to this project are documented in this file.

## 2.0.0-beta.1 - 2026-11-23

2.0 is a breaking release. The README has a migration guide (1.x to 2.0) with every change and the list of removed symbols.

### Breaking

- Minimum deployments are now iOS 17, macOS 14, Mac Catalyst 17, tvOS 17 and watchOS 10.
- `SwiftUIExtensions` is an explicit library product.
- The helpers that lived in `InternalAPI` moved to the separate `SwiftUIHelpersUnsafe` product, which is not covered by semantic versioning.
- Several APIs were renamed or removed; see the migration guide.

### Added

- `SwiftUIHelpersUnsafe`: `colorMatrix(_:)`, `ShapeStyle.fillingContainerShape()`, `onEnvironmentChange(_:perform:)`, `onBindingChange(_:perform:)`, `listLinkedGroup(_:)` (watchOS only) and `textSelectionGroup()`.
- `textSelectionGroup()` groups several `Text` views into one selection region. It uses a private SwiftUI modifier that exists in OS 27 and later, does nothing where the modifier is missing, and should not be shipped in App Store apps.

### Fixed

- The package builds for tvOS and watchOS. The key-window helpers are not available on watchOS.
