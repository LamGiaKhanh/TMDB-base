//
//  Stepper.swift
//  Common
//
//  Created by Phat Le on 29/04/2022.
//

import Combine

public protocol Stepper: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
    var steps: PassthroughSubject<Step, Never> { get }
}
