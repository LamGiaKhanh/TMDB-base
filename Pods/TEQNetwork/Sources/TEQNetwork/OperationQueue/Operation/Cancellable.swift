//
//  Cancellable.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/16/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

public class Cancellable {
    weak var operation: WorkerOperation?

    init(operation: WorkerOperation) {
        self.operation = operation
    }

    public func cancel() {
        operation?.cancel()
    }
}
