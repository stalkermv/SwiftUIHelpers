//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import Foundation

public extension URL {
    enum PlaceholderImage { }
}

public extension URL.PlaceholderImage {
    /// Generates a image URL with person
    static func person(width: Int = 640, height: Int = 360) -> URL {
        return URL(string: "http://placebeard.it/\(width)/\(height)")!
    }
    
    /// Generates a image URL with kitten
    static func kitten(width: Int = 640, height: Int = 360) -> URL {
        return URL(string: "http://placekitten.com/\(width)/\(height)")!
    }
    
    /// Generates a image URL with gray placeholder
    static func placehodler(width: Int = 640, height: Int = 360) -> URL {
        return URL(string: "http://fakeimg.pl/\(width)x\(height)")!
    }
}
