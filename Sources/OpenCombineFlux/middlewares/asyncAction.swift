//
//  asyncAction.swift
//  OpenCombineFlux
//
//  Created by Pierre Perrin on 29/04/2020.
//

import Foundation

public let asyncActionsMiddleware: Middleware<StateType> = { dispatch, getState in
    return { next in
        return { action in
            
            switch action {
            case let action as AsyncAction:
                action.execute(state: getState(), dispatch: dispatch)
                fallthrough
            default:
                 return next(action)
            }
        }
    }
}
