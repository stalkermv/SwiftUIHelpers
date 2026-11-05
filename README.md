# SwiftUIHelpers

A collection of SwiftUI extensions and helpers for iOS/macOS development. **Version 2.0 is a breaking release** — see the [migration guide](#migration-guide-1x--20) before upgrading.

---

## Platforms

| Platform | Minimum |
|---|---|
| iOS | 17.0 |
| macOS | 14.0 |
| Mac Catalyst | 17.0 |
| tvOS | 17.0 |
| watchOS | 10.0 |

A few APIs are not available on every platform:

- tvOS: `onTouchDownGesture` and `embedInNavigation` are not available (no `DragGesture` / navigation bar title mode). `Font.TextStyle.largeTitle` maps to `title1`.
- watchOS: the `FontProvider` API (`PlatformFont.resolving(font:dynamicTypeSize:)` and related types), `UIApplication.keyWindow` / `endEditing()` and `UIColor(light:dark:)` are not available.
- tvOS and watchOS: `HoverGroup` compiles but `isGroupHovering` is always `false`. `scrollDisabled(_:during:)` needs tvOS 18 / watchOS 11.

---


## Installation

### Swift Package Manager

Add the following to the `dependencies` array in your `Package.swift`:

```swift
.package(url: "https://github.com/stalkermv/SwiftUIHelpers", from: "2.0.0")
```

Then add **both products** to your target's `dependencies`:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "SwiftUIHelpers", package: "SwiftUIHelpers"),
        .product(name: "SwiftUIExtensions", package: "SwiftUIHelpers"),
    ]
)
```

> **CustomComponents-style consumers:** if you previously imported only `SwiftUIHelpers`, you must add `SwiftUIExtensions` to your target's `Package.swift` when moving to 2.0. `SwiftUIExtensions` is now an explicit library product; it was only reachable by transitive accident in 1.x.

---

## Module map

| API | Module |
|---|---|
| `Binding ??`, `Binding.boolean()`, `Binding.equals(_:)`, `Binding(_:key:in:)` | `SwiftUIExtensions` |
| `Color.random`, `Color.accessibleFontColor` | `SwiftUIExtensions` |
| `ContentSizeCategory.init(_: DynamicTypeSize)` | `SwiftUIExtensions` |
| `EdgeInsets(horizontal:vertical:)` | `SwiftUIExtensions` |
| `Image.resizable(contentMode:)` | `SwiftUIExtensions` |
| `View.hidden(_:transition:remove:)`, `HiddenModifier` | `SwiftUIExtensions` |
| `View.padding(_:for: .hitTestArea)` | `SwiftUIExtensions` |
| `HoverGroup`, `View.hoverGroup()`, `EnvironmentValues.isGroupHovering` | `SwiftUIExtensions` |
| `View.embedInNavigation()` | `SwiftUIExtensions` |
| `UIApplication.keyWindow`, `UIApplication.endEditing()` | `SwiftUIExtensions` |
| `UIColor(light:dark:)` | `SwiftUIExtensions` |
| `UIFont.TextStyle`, `UIFont.Weight`, `UIFontDescriptor.SystemDesign` font mapping | `SwiftUIExtensions` |
| `isPreview` environment key | `SwiftUIExtensions` |
| `ApplicationMiddleware` + builder | `SwiftUIHelpers` |
| `StateOrBinding`, `EnvironmentOrValue`, `StatefulContainer` | `SwiftUIHelpers` |
| `SelectableArray` + page metadata | `SwiftUIHelpers` |
| `View.defaultScrollAnchor(index:count:)` | `SwiftUIHelpers` |
| `View.scrollDisabled(_:during:)` (iOS 18+) | `SwiftUIHelpers` |
| `View.scrollPosition(selectable:)` | `SwiftUIHelpers` |
| `HierarchicalPaletteShapeStyle`, `HierarchicalPaletteConfiguration` (**experimental**) | `SwiftUIHelpers` |
| `LabelColorShapeStyleProvider` (**experimental**) | `SwiftUIHelpers` |
| `PlatformFont.resolving(font:dynamicTypeSize:)` (**experimental**) | `SwiftUIHelpers` |
| `FitPresentationDetent` + `View.fitPresentationDetent()` | `SwiftUIHelpers` |
| `NavigationLinkStyle` | `SwiftUIHelpers` |
| `Previewable` | `SwiftUIHelpers` |
| `GeometryEffectView`, `View.geometryEffectLayer(_:)` | `SwiftUIHelpers` |
| `UIColor(HexColorContainer)` | `SwiftUIHelpers` |
| `ShapeStyleBuilder`, `View.foregroundStyle(_:)` builder overload | `SwiftUIHelpers` |
| `View.hidden(for: DynamicTypeSize...)` | `SwiftUIHelpers` |
| `View.onTouchDownGesture(_:)` | `SwiftUIHelpers` |
| `View.position(point:in:)` | `SwiftUIHelpers` |

---

## API cheat sheet

### Binding (`SwiftUIExtensions`)

```swift
// Nil-coalescing unwrap
let nonOptional: Binding<String> = $optionalString ?? "default"

// Boolean binding from optional (method in 2.0 — was a property in 1.x)
let isPresented: Binding<Bool> = $optionalValue.boolean()

// Boolean binding tied to a specific value
let isEditing: Binding<Bool> = $selectedMode.equals(.edit)

// Key-path binding — binds a selection to an element identified by key path
let elementBinding = Binding(&$selection, key: \.id, in: myArray)
```

### Color (`SwiftUIExtensions`)

```swift
// Random color (useful in previews)
let c = Color.random

// WCAG-contrast-correct font color for any background
Text("Hello").foregroundColor(backgroundColor.accessibleFontColor)
```

### View modifiers (`SwiftUIExtensions`)

```swift
// Conditionally hide/show; default transition is .identity
view.hidden(shouldHide)
view.hidden(shouldHide, transition: .opacity)
view.hidden(shouldHide, remove: true)  // removes from layout

// Expand hit-test area without growing visible bounds
view.padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8), for: .hitTestArea)
view.padding(.all, 12, for: .hitTestArea)

// Embed in a NavigationView (iOS/macCatalyst)
view.embedInNavigation()

// Hover group — propagates hover state to descendants via environment
HoverGroup { content }
view.hoverGroup()
// Inside descendants:
@Environment(\.isGroupHovering) var isHovering

// Resizable image with content mode
Image("logo").resizable(contentMode: .fit)
```

### Property wrappers (`SwiftUIHelpers`)

```swift
// StateOrBinding — use the same view whether you own the state or receive a binding
@StateOrBinding var text: String = "initial"

// EnvironmentOrValue — fall back to a literal when no environment is injected
@EnvironmentOrValue(\.colorScheme) var scheme: ColorScheme = .light

// StatefulContainer — drives a child view with an @State wrapper
StatefulContainer(initialValue: 0) { $count in
    Stepper("Count: \(count)", value: $count)
}

// SelectableArray — array + selection index as a single @State value
@State var items = SelectableArray(elements: myList)
```

### Scroll helpers (`SwiftUIHelpers`)

```swift
// Anchor the scroll position based on an index in a list
ForEach(items.indices, id: \.self) { i in
    RowView(items[i])
        .defaultScrollAnchor(index: i, count: items.count)
}

// Disable scroll during a specific phase (iOS 18+ / macOS 15+)
ScrollView {
    content
}.scrollDisabled(true, during: .decelerating)

// Drive a scroll view from a SelectableArray
ScrollView {
    content
}.scrollPosition(selectable: items)
```

### Palette (`SwiftUIHelpers`, experimental)

```swift
struct MyPalette: HierarchicalPaletteShapeStyle {
    func resolve(in environment: EnvironmentValues, for level: HierarchicalPaletteLevel) -> Color {
        switch level {
        case .primary:   return .black
        case .secondary: return .gray
        default:         return .gray.opacity(0.7)
        }
    }
}
```

### Detent (`SwiftUIHelpers`)

```swift
.sheet(isPresented: $show) {
    ContentView()
        .fitPresentationDetent()
}
```

### Middleware (`SwiftUIHelpers`)

```swift
struct AppMiddleware: ApplicationMiddleware {
    var body: some ApplicationMiddleware {
        NotificationMiddleware()
        AnalyticsMiddleware()
    }
}
```

### Misc

```swift
// Previewable — provide static preview instances for types
extension MyModel: Previewable {
    static func makePreview(idx: Int) -> Self { ... }
}

// NavigationLinkStyle — custom ButtonStyle for navigation links
struct MyLinkStyle: NavigationLinkStyle {
    func makeBody(configuration: Configuration) -> some View { ... }
}

// UIColor adaptive (iOS/macCatalyst)
let adaptive = UIColor(light: .white, dark: .black)

// UIColor from hex container
let color = UIColor(hexContainer)

// UIApplication helpers (iOS/macCatalyst)
UIApplication.shared.keyWindow
UIApplication.shared.endEditing()

// DynamicTypeSize → ContentSizeCategory
let cat = ContentSizeCategory(.large)

// Geometry effect layer
view.geometryEffectLayer { content, proxy in
    content.offset(x: proxy.size.width * 0.1)
}
```

---

## Experimental

The following features depend on **private/underscored SwiftUI internals** and are **not covered by semver**:

> **EXPERIMENTAL — relies on private SwiftUI internals; may break without warning on any OS update; not covered by semver.**

- **`HierarchicalPaletteShapeStyle`** / **`HierarchicalPaletteConfiguration`** — uses Mirror over `_ShapeStyle_Shape` to resolve hierarchical foreground colors.
- **`LabelColorShapeStyleProvider`** — uses the same introspection mechanism to derive label colors from background styles.
- **`PlatformFont.resolving(font:dynamicTypeSize:)`** / FontProvider stack — uses Mirror over SwiftUI Font internals to obtain a platform font.

These types stay in `SwiftUIHelpers` because the author's apps rely on them and no stable alternative exists. The honesty is in the labeling.

---

## SwiftUIHelpersUnsafe

`SwiftUIHelpersUnsafe` is a separate product with the helpers that used to live in `InternalAPI` in 1.x: `tightPadding`, `automaticPadding`, `ignoresAutomaticPadding`, `safeAreaInsets`, `scrollable`, `identified(by:)`, `colorMonochrome`, `addingBackgroundGroup`, `addingBackgroundLayer`, `defaultContext`, `stylisticAlternative`, `lineHeightMultiple`, `detached` / `DetachedView`, `PreferenceKey.delay` and `force`. The names are the same as in 1.x. Since 2.0 it also has `colorMatrix(_:)`, `ShapeStyle.fillingContainerShape()`, `onEnvironmentChange(_:perform:)`, `onBindingChange(_:perform:)` and `listLinkedGroup(_:)` (watchOS only).

> **Experimental.** These are thin wrappers around underscored SwiftUI internals. They can break on any OS update, are not covered by semver, and may change in minor releases.

```swift
.product(name: "SwiftUIHelpersUnsafe", package: "SwiftUIHelpers")
```

## Known limitations

> These probes instantiate `StateOrBinding` and `EnvironmentOrValue` directly outside SwiftUI's render loop, which means `@State`'s internal `_value` node is `nil` throughout every test. Reads fall back to the `initialValue` captured at init time, and writes via `wrappedValue` setter are no-ops (the setter calls through to a nil node). Consequently, the state round-trip test cannot assert a specific post-write value and instead only verifies the call does not crash. `update()` is similarly a no-op outside a live View body, so calling it here proves absence of crashes, not correctness of SwiftUI graph registration. `EnvironmentOrValue` with a key-path init reads from a freshly constructed `EnvironmentValues()` default rather than from any injected environment, so the returned value reflects the platform default (typically `.light` for `colorScheme`) rather than any real environment. These wrappers are designed for use inside live SwiftUI view bodies; verify behavior in previews before relying on them.

---

## Migration guide 1.x → 2.0

| # | Change | Old | New |
|---|---|---|---|
| B1 | Platform floor | iOS 15/macOS 13/tvOS 15/watchOS 8 | iOS 17/macOS 14/macCatalyst 17/tvOS 17/watchOS 10 |
| B2 | `SwiftUIExtensions` product | No SPM product; importable only by transitive accident | Add `.product(name: "SwiftUIExtensions", package: "SwiftUIHelpers")` to your target |
| B3 | Custom detent API | `SwiftUIHelpers.PresentationDetent.fit` + `presentationDetent(_:)` | `FitPresentationDetent.fit` + `fitPresentationDetent()` |
| B4 | InternalAPI deleted | 15+ underscored helpers public in `SwiftUIHelpers` | Moved to the separate `SwiftUIHelpersUnsafe` product (same names, not covered by semver) |
| B5 | Engine/Turbocharger conformances | `BackgroundStyle`/`TintShapeStyle: LabelColorShapeStyleProvider` under `canImport(Engine)` | Deleted — move conformance into the repo that owns Engine |
| B6 | Demo removed | `HierarchicalPaletteDemoScreen` etc. | Deleted — no action needed |
| B7 | `_softwareKeyboard` removed | Public private-API keyboard hack | Deleted — keep in app code if needed |
| B8 | Ghost APIs confirmed absent | `toggleAction`, `NavigationLink(isActive:)`, `readSize`, `cornerRadius(UIRectCorner)`, `previewOnDevices` in old README | Never existed in the library; nothing to migrate |
| B9 | `Binding(_:key:in:)` nil semantics | Setter ignored `nil` (selection could never be cleared) | Setting `.none` now writes `nil` to the target binding |
| B10 | `hidden` unified | Mixed defaults; no-op on iOS 15–16 | Single default `.identity` transition; opacity-0 + `accessibilityHidden` on all supported OS |
| B11 | `Color.accessibleFontColor` | 2-of-3-channels > 0.65 heuristic | WCAG relative luminance — visual diff possible for mid-tones |
| B12 | `SelectableArray.==` | Compared only `elements` | Still compares `elements` only (documented); use `isSameSelection(as:)` to include selection index |
| B13 | Scene `onChange`/`onReceive`/`modifier` extensions | `_SceneModifier`-based hacks | Deleted — use `.onChange(of:)`/`.onReceive` on the scene's root view instead |
| B14 | Font mapping deduplication | Tables duplicated across modules with `default:` swallowing unknowns | Single internal table; `@unknown default` with body fallback |
| B15 | `NamedProvider` descriptor attribute | `.family: name` — silently wrong face | `.name: name` (PostScript name) — fixes broken named-font rendering |
| B16 | `LabelColorShapeStyle` crash | `fatalError("Unable to cast environment")` | Graceful fallback + debug `assertionFailure` |
| B17 | Hover group finalized | `HoverVisibilityCondition` enum (unused) | Enum removed; `IsGroupHoveringEnvironmentKey` made internal |
| B18 | `swift-log` removed | `Logger.hierarchicalPalette` diagnostic logger | Removed — diagnostic-only; consumers never configured it |
| B19 | GeometryEffect API | Deprecated `View.geometryEffect` overload with circular message | `View.geometryEffectLayer(_:)` — rename at call sites |
| B20 | `Binding.boolean` property → method | `$x.boolean` | `$x.boolean()` — append `()` at all call sites |
| B21 | `Binding(_, equals:)` initializer → method | `Binding($x, equals: v)` | `$x.equals(v)` — replace initializer call with method call |

---

## Deleted in 2.0

The following symbols were removed from the public API. They are available in `git tag 1.1.8` and can be copied into your own codebase.

**InternalAPI symbols:**
`DetachedPlaceholder`, `DetachedView`, `EmptyDetached`, `View.detached`, `EnvironmentValues.lineHeightMultiple`, `PreferenceKey.delay`, `_PreferenceValue.force`, `Text.stylisticAlternative`, `addingBackgroundGroup`, `addingBackgroundLayer`, `defaultContext`, `automaticPadding`, `colorMonochrome`, `identified(by:)`, `ignoresAutomaticPadding`, `safeAreaInsets(_:)` overloads, `scrollable(...)`, `tightPadding`

**Scene extensions:** `Scene.onChange`, `Scene.onReceive`, `Scene.modifier`

**Other:** `_softwareKeyboard`, Engine/Turbocharger conformances, `HierarchicalPaletteDemoScreen` and related demo views, `Environment_IsPreview` sample view, `Logger.hierarchicalPalette`

---

## Contributing

Contributions are welcome. Please add documentation and tests for any changes.

## License

Released under the MIT License. See [LICENSE](LICENSE) for details.
