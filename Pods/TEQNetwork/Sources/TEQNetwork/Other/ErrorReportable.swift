//
//  ErrorReportable.swift
//  
//
//  Created by Nghia Nguyen on 4/23/20.
//

import Foundation

public protocol ErrorReportable {
    func report(error: Error)
}
