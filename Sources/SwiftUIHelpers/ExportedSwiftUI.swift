//  Why do I need to re-export the SwiftUI module?
//
//  Some code in this package relies on certain SwiftUI structures or types.
//  In order to use these types in your code without having to explicitly import the original module,
//  I've defined a module re-export.
//
//  Re-exporting a module essentially makes all of its public types and functions available in the module
//  that imports it, and at the same time in the project that imports the module.
//
//  By re-exporting the SwiftUI module here, you don't have to import SwiftUI
//  when you imported this package.


@_exported import SwiftUI
