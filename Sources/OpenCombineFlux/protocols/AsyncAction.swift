//
//  AsyncAction.swift
//  OpenCombineFlux
//
//  Created by Pierre Perrin on 29/04/2020.
//

import Foundation

public protocol AsyncAction: Action {
    func execute(state: StateType?, dispatch: @escaping DispatchFunction)
}
