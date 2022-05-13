//
//  Dictionary++.swift
//  Common
//
//  Created by Phat Le on 05/04/2022.
//

import Foundation

public extension Dictionary {
    mutating func append(_ dic: [Key: Value]?) {
        guard let dic = dic else { return }
        for (k, v) in dic {
            updateValue(v, forKey: k)
        }
    }
}
