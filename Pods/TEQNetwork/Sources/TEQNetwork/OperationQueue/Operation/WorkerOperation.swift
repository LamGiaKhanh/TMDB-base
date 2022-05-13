//
//  WorkerOperation.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/19/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation

typealias WorkerCallback = () -> Void

final class WorkerOperation: AsynchronousOperation {
    let id: String
    var mainTask: ((@escaping WorkerCallback) -> Void)?
    var cancelTask: WorkerCallback?

    init(id: String, mainTask: ((@escaping WorkerCallback) -> Void)?, cancelTask: WorkerCallback?) {
        self.id = id
        self.mainTask = mainTask
        self.cancelTask = cancelTask
    }

    deinit {
        log("WorkerOperation (\(id)) - deinit!")
    }

    override func main() {
        log("WorkerOperation (\(id)) - run main task!")
        mainTask? { [weak self] in
            self?.finish()
        }
    }

    override func cancel() {
        if !isCancelled && !isFinished {
            log("WorkerOperation (\(id)) - cancel!")
            cancelTask?()
        }
        finish()
    }
}
