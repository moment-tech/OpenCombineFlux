//
//  loggingMiddleWare.swift
//  OpenCombineFlux
//
//  Created by Pierre Perrin on 29/04/2020.
//

import Foundation

public let simpleLoggingActionsMiddleware: Middleware<StateType> = { dispatch, getState in
    return { next in
        return { action in
            
            print("Performing Action: \(action)")
            next(action)
        }
    }
}
