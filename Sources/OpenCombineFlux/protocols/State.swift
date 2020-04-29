//
//  State.swift
//  OpenCombineFlux
//
//  Created by Pierre Perrin on 29/04/2020.
//

import Foundation

public protocol StateType {}

public protocol SimpleStateType: StateType {
    static func reducer(state: Self, action: Action) -> Self
    init()
}

public extension SimpleStateType {

    static func newStore(middleware: [Middleware<Self>] = [],
                         initialState: Self = .init()) -> Store<Self> {
        return Store<Self>.init(reducer: reducer, middleware: middleware, state: initialState)
    }
}
