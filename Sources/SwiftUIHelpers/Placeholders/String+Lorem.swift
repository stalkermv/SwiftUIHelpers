//
//  Created by Valeriy Malishevskyi on 06.05.2023.
//

import Foundation

public extension String {
    enum Lorem { }
}

public extension String.Lorem {
    
    /// Generates a single word.
    static var word: String {
        words.randomElement()!
    }
    
    /// Generates multiple words whose count is defined by the given value.
    ///
    /// - Parameter count: The number of words to generate.
    /// - Returns: The generated words joined by a space character.
    static func words(_ count: Int) -> String {
        _compose(
            word,
            count: count,
            join: .space
        )
    }
    
    /// Generates a single sentence.
    static var sentence: String {
        let numberOfWords = Int.random(
            in: minWordsCountInSentence...maxWordsCountInSentence
        )
        
        return _compose(
            word,
            count: numberOfWords,
            join: .space,
            endWith: .dot,
            decorate: { $0.firstLetterCapitalized }
        )
    }
    
    /// Generates multiple sentences whose count is defined by the given value.
    ///
    /// - Parameter count: The number of sentences to generate.
    /// - Returns: The generated sentences joined by a space character.
    static func sentences(_ count: Int = 1) -> String {
        return _compose(
            sentence,
            count: count,
            join: .space
        )
    }
    
    // MARK: - Private Helpers
    
    fileprivate static let minWordsCountInSentence = 4
    fileprivate static let maxWordsCountInSentence = 16
    
    private static let words: [String] = [
        "lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
        "curabitur", "vel", "accumsan", "hendrerit", "libero", "aliquam", "eleifend", "blandit",
        "nunc", "ornare", "odio", "auctor", "ut", "eros", "blandit",
        "class", "commodo", "condimentum", "congue", "consequat", "conubia",
        "convallis", "cras", "cubilia", "curabitur", "curae", "cursus",
        "dapibus", "diam", "dictum", "dictumst", "dignissim", "dis", "donec",
        "dui", "duis", "efficitur", "egestas", "eget", "eleifend", "elementum",
        "enim", "erat", "eros", "est", "et", "etiam", "eu", "euismod", "ex",
        "facilisi", "facilisis", "fames", "faucibus", "felis", "fermentum",
        "feugiat", "finibus", "fringilla", "fusce", "gravida", "habitant",
        "habitasse", "hac", "hendrerit", "himenaeos", "iaculis", "id",
        "imperdiet", "in", "inceptos", "integer", "interdum", "justo",
        "lacinia", "lacus", "laoreet", "lectus", "leo", "libero", "ligula",
        "litora", "lobortis", "luctus", "maecenas", "magna", "magnis",
        "malesuada", "massa", "mattis", "mauris", "maximus", "metus", "mi",
        "molestie", "mollis", "montes", "morbi", "mus", "nam", "nascetur",
        "natoque", "nec", "neque", "netus", "nibh", "nisi", "nisl", "non",
        "nostra", "nulla", "nullam", "nunc", "odio", "orci", "ornare",
        "parturient", "pellentesque", "penatibus", "per", "pharetra",
        "phasellus", "placerat", "platea", "porta", "porttitor", "posuere",
        "potenti", "praesent", "pretium", "primis", "proin", "pulvinar",
        "purus", "quam", "quis", "quisque", "rhoncus", "ridiculus", "risus",
        "rutrum", "sagittis", "sapien", "scelerisque", "sed", "sem", "semper",
        "senectus", "sociosqu", "sodales", "sollicitudin", "suscipit",
        "suspendisse", "taciti", "tellus", "tempor", "tempus", "tincidunt",
        "torquent", "tortor", "tristique", "turpis", "ullamcorper", "ultrices",
        "ultricies", "urna", "ut", "varius", "vehicula", "vel", "velit",
        "venenatis", "vestibulum", "vitae", "vivamus", "viverra", "volutpat",
        "vulputate",
    ]
    
    fileprivate enum Separator: String {
        case none = ""
        case space = " "
        case dot = "."
        case newLine = "\n"
    }
    
    fileprivate static func _compose(
        _ provider: @autoclosure () -> String,
        count: Int,
        join middleSeparator: Separator,
        endWith endSeparator: Separator = .none,
        decorate decorator: ((String) -> String)? = nil
    ) -> String {
        var string = ""
        
        for index in 0..<count {
            string += provider()
            
            if (index < count - 1) {
                string += middleSeparator.rawValue
            } else {
                string += endSeparator.rawValue
            }
        }
        
        if let decorator = decorator {
            string = decorator(string)
        }
        
        return string
    }
}

private extension String {
    var firstLetterCapitalized: String {
        guard !isEmpty else { return self }
        return prefix(1).capitalized + dropFirst()
    }
}
