//
//  Reducer.swift
//  OpenCombineFlux
//
//  Created by Pierre Perrin on 29/04/2020.
//

import Foundation

public typealias Reducer<ReducerState: StateType> =
    (_ state: ReducerState, _ action: Action) -> ReducerState
