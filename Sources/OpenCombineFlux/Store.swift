//
//  Store.swift
//  OpenCombineFlux
//
//  Created by Pierre Perrin on 29/04/2020.
//

import Foundation
import OpenCombine

final public class Store<StoreState: StateType> {
    
    @OpenCombine.Published public var state: StoreState
    
    private var dispatchFunction: DispatchFunction!
    private let reducer: Reducer<StoreState>
    
    public init(reducer: @escaping Reducer<StoreState>,
                middleware: [Middleware<StoreState>] = [],
                state: StoreState) {
        self.reducer = reducer
        self.state = state
        
        var middleware = middleware
        #if DEBUG
        middleware.append(simpleLoggingActionsMiddleware)
        #endif
        middleware.append(asyncActionsMiddleware)
        self.dispatchFunction = middleware
            .reversed()
            .reduce(
                { [unowned self] action in
                    self._dispatch(action: action) },
                { dispatchFunction, middleware in
                    let dispatch: (Action) -> Void = { [weak self] in self?.dispatch(action: $0) }
                    let getState = { [weak self] in self?.state }
                    return middleware(dispatch, getState)(dispatchFunction)
            })
    }

    public func dispatch(action: Action) {
        Thread.current.isMainThread ? { dispatchFunction(action) }() :
            DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    private func _dispatch(action: Action) {
        state = reducer(state, action)
    }
    
}
