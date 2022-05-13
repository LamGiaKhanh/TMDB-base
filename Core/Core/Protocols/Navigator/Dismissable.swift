//
//  Dismissable.swift
//  Common
//
//  Created by Phat Le on 29/04/2022.
//

import Foundation

public protocol Dismissable {
    func dismiss()
}

public extension Dismissable {
    func dismiss() {}

    func delayDismiss(disList: [Dismissable?], delay: Double = 0.12) {
        var deadline: DispatchTime = .now()
        for (i, dis) in disList.compactMap({$0}).enumerated() {
            deadline = deadline + delay * Double(i + 1)
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                dis.dismiss()
            }
        }
    }
}
