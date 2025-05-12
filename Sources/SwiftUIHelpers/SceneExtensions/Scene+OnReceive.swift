//
//  Scene+OnReceive.swift
//  SwiftUIHelpers
//
//  Created by Valeriy Malishevskyi on 13.12.2024.
//

import SwiftHelpers
import Combine
import SwiftUI

extension Scene {
    public func onReceive<P>(_ publisher: P, perform action: @escaping (P.Output) -> Void) -> some Scene
    where P : Publisher, P.Failure == Never {
        modifier(_PublisherActionModifier(publisher: publisher, action: action))
    }
}

struct _PublisherActionProperty<P> : DynamicProperty
where P : Publisher, P.Failure == Never {
    private var cancelable: AnyCancellable?
    
    private let publisher: P
    private let action: (P.Output) -> Void
    
    let nonChangingValue = 1
    
    init(publisher: P, action: @escaping (P.Output) -> Void) {
        self.publisher = publisher
        self.action = action
    }
    
    nonisolated mutating func update() {
        guard cancelable == nil else { return }
        cancelable = publisher.sink(receiveValue: action)
    }
}

struct _PublisherActionModifier<P> : _SceneModifier where P : Publisher, P.Failure == Never {
    let property: _PublisherActionProperty<P>
    
    public init(publisher: P, action: @escaping (P.Output) -> Void) {
        self.property = _PublisherActionProperty(publisher: publisher, action: action)
    }
    
    func body(content: SceneContent) -> some Scene {
        content.onChange(of: "") { _ in }
    }
}
