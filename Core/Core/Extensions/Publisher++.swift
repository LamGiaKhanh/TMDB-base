//
//  Publisher++.swift
//  Common
//
//  Created by Phat Le on 29/04/2022.
//

import Combine

public extension Publisher {
    func ignore() -> AnyCancellable {
        return sink { result in
            //
        } receiveValue: { value in
            //
        }
    }
}
