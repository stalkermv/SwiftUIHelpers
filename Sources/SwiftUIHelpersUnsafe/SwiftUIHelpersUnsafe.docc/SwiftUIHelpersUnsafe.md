# ``SwiftUIHelpersUnsafe``

Thin public wrappers around underscored SwiftUI internals.

> Warning: Experimental. Everything in this module calls underscored SwiftUI APIs that Apple does not document or support. They can change or disappear in any OS update. This module is not covered by semantic versioning and may break in minor releases of SwiftUIHelpers.

## Overview

These helpers were part of `SwiftUIHelpers` 1.x (`InternalAPI`). They live in a separate product so that nothing unstable leaks into the main API. Import it only where you need it:

```swift
import SwiftUIHelpersUnsafe
```

## Topics

### Text Selection Group

- ``SwiftUICore/View/textSelectionGroup()``
- ``TextSelectionGroupModifier``
