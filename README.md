# SwiftUIHelpers

This is a collection of SwiftUI extensions to make development easier.

Installation
------------

### Swift Package Manager

Add the following line to the dependencies in your `Package.swift` file:


```swift
.package(url: "https://github.com/stalkermv/SwiftUIHelpers", from: "1.0.0")
```

Then, add `SwiftUIHelpers` to your target's dependencies:


```swift
.target(name: "YourTarget", dependencies: ["SwiftHelpers"])
```

Usage
-----

After installing the library, simply import `SwiftUIHelpers` at the top of your Swift files and start using the provided extensions and helper functions.

```swift
import SwiftUIHelpers
```

### UIColor

*   `init(light: UIColor, dark: UIColor)`: Creates a `UIColor` instance that adapts to the current interface style (light or dark) by returning the appropriate color.
*   `init(red: Int, green: Int, blue: Int)`: Creates a `UIColor` instance with the specified red, green, and blue values.
*   `init(rgb: Int)`: Creates a `UIColor` instance with the specified RGB value.
*   `init?(hex: String)`: Creates a `UIColor` instance with the specified hexadecimal value.

### UIApplication

*   `var keyWindow: UIWindow?`: Returns the key window of the application, if one exists.
*   `func endEditing()`: Ends editing on the key window of the application.

### Binding

*   `func toggleAction() -> () -> Void`: Returns a closure that toggles the wrapped value of the binding.
*   `func toggleAction(_ animation: Animation = .easeInOut) -> () -> Void`: Returns a closure that toggles the wrapped value of the binding, with the specified animation.
*   `init(value: Value, action: @escaping () -> Void)`: Creates a binding with the specified value and closure to be called when the binding is set.
*   `init(value: Value, action: @escaping (Value) -> Void)`: Creates a binding with the specified value and closure to be called when the binding is set.
*   `init(get: @escaping () -> Value, action: @escaping () -> Void)`: Creates a binding with the specified getter and closure to be called when the binding is set.
*   `init(get: @escaping () -> Value, action: @escaping (Value) -> Void)`: Creates a binding with the specified getter and closure to be called when the binding is set.
*   `init(readOnly get: @escaping () -> Value)`: Creates a read-only binding with the specified getter.
*   `init(value: Value)`: Creates a binding with the specified value.

### NavigationLink

*   `init(destination: Destination, isActive: Binding<Bool>)`: Creates a navigation link with the specified destination and binding to the active state.
*   `init(isActive: Binding<Bool>, @ViewBuilder destination: @escaping () -> Destination)`: Creates a navigation link with a lazy destination and binding to the active state.

### View

*   `func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View`: Rounds the specified corners of the view.
*   `func embedInNavigationView() -> some View`: Embeds the view in a `NavigationView`.
*   `func readSize(onChange: @escaping (CGSize) -> Void) -> some View`: Adds a hidden view with a `GeometryReader` to read the size of the view, then calls the specified closure with the size whenever it changes.
*   `func readFrameWidth(_ width: Binding<CGFloat>) -> some View`: Adds a hidden view with a `GeometryReader` to read the width of the view, then sets the specified binding to the width whenever it changes.
*   `func readFrameHeight(_ height: Binding<CGFloat>) -> some View`: Adds a hidden view with a `GeometryReader` to read the height of the view, then sets the specified binding to the height whenever it changes.
*   `func hidden(_ hidden: Bool, remove: Bool = false) -> some View`: Hides or removes the view depending on the specified boolean value.

*   `func hidden<V: View>(_ hidden: Bool, remove: Bool = false, placeholder: () -> V) -> some View`: Hides or removes the view depending on the specified boolean value, and overlays a placeholder view in its place.
*   `func hidden<V: View>(_ hidden: Bool?, remove: Bool = false, placeholder: () -> V) -> some View`: Hides or removes the view depending on the specified optional boolean value, and overlays a placeholder view in its place.
*   `static func previewOnDevices<V: View>(_ devices: [PreviewDevice] = PreviewDevice.allCases, @ViewBuilder contentBuilder: @escaping () -> V) -> some View`: Creates a group of previews for the specified devices, each with the specified view.

### RoundedCorner

*   `init(radius: CGFloat, corners: UIRectCorner)`: Creates a `RoundedCorner` shape with the specified radius and corners.

### SizePreferenceKey

*   `struct SizePreferenceKey`: A preference key for reading the size of a view.


Contributing
------------

Contributions to SwiftHelpers are welcome! Feel free to submit a pull request with new features, improvements, or bug fixes. Please make sure to add documentation and unit tests for any changes you make.

License
-------

SwiftHelpers is released under the MIT License. See the [LICENSE](LICENSE) file for more information.
