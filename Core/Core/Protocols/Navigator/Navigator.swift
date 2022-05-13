//
//  Navigator.swift
//  Common
//
//  Created by Phat Le on 27/04/2022.
//

import Foundation
import Combine

public protocol Navigator: AnyObject, Dismissable {
    func go(to step: Step)
}

public extension Navigator {
    func contribute(_ stepper: Stepper?) {
        guard let stepper = stepper else { return }
        stepper.steps.sink { [weak self] step in
            guard let self = self else { return }
            self.go(to: step)
        }
        .store(in: &stepper.cancellables)
    }

    func contribute(_ steppers: [Stepper?]) {
        steppers.forEach { contribute($0) }
    }
}
