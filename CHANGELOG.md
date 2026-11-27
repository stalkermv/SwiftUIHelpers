# Changelog

All notable changes to this project are documented in this file.

## Unreleased

### Added

- `View.position(point:)` places the center of a view at a unit point of the space it is offered, such as `.topTrailing`.

### Deprecated

- `View.position(point:in:)`. Now that the coordinate space no longer changes where the view lands, use `position(point:)`.

### Fixed

- `position(point:in:)` places the view correctly when the frame is measured in `.global` or a named coordinate space. The point is now converted back to the parent's local coordinates before positioning; before, a nonlocal frame origin was added on top and the view landed off target.
- README examples for `StateOrBinding`, `EnvironmentOrValue`, `StatefulContainer` and `SelectableArray` now match the public API and compile. The `EnvironmentOrValue` documentation shows how to pass an explicit value.

## 2.0.0-beta.3 - 2026-11-24

### Changed

- `View.presentationDetent(_:)` is the public API again, as in 1.x: `.presentationDetent(.fit)`. The detent type is still named `FitPresentationDetent` so that it does not clash with SwiftUI's `PresentationDetent`; call sites only write `.fit`.

### Removed

- `View.fitPresentationDetent()`, which existed only in `2.0.0-beta.1` and `2.0.0-beta.2`. Use `.presentationDetent(.fit)`.

## 2.0.0-beta.2 - 2026-11-23

### Fixed

- `textSelectionGroup()` documentation and tests now state the correct OS version: the private modifier it uses exists in OS 27.2 and later and is missing on 27.0, where the helper does nothing.
- CI runs on Xcode 27.2 and compiles for iOS, tvOS and watchOS.

## 2.0.0-beta.1 - 2026-11-23

2.0 is a breaking release. The README has a migration guide (1.x to 2.0) with every change and the list of removed symbols.

### Breaking

- Minimum deployments are now iOS 17, macOS 14, Mac Catalyst 17, tvOS 17 and watchOS 10.
- `SwiftUIExtensions` is an explicit library product.
- The helpers that lived in `InternalAPI` moved to the separate `SwiftUIHelpersUnsafe` product, which is not covered by semantic versioning.
- Several APIs were renamed or removed; see the migration guide.

### Added

- `SwiftUIHelpersUnsafe`: `colorMatrix(_:)`, `ShapeStyle.fillingContainerShape()`, `onEnvironmentChange(_:perform:)`, `onBindingChange(_:perform:)`, `listLinkedGroup(_:)` (watchOS only) and `textSelectionGroup()`.
- `textSelectionGroup()` groups several `Text` views into one selection region. It uses a private SwiftUI modifier that exists in OS 27.2 and later, does nothing where the modifier is missing, and should not be shipped in App Store apps.

### Fixed

- The package builds for tvOS and watchOS. The key-window helpers are not available on watchOS.
