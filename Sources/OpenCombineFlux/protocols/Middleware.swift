//
//  Middleware.swift
//  OpenCombineFlux
//
//  Created by Pierre Perrin on 29/04/2020.
//

import Foundation

public typealias Middleware<State> =
    (@escaping DispatchFunction, @escaping () -> StateType?)
    -> (@escaping DispatchFunction)
    -> DispatchFunction
