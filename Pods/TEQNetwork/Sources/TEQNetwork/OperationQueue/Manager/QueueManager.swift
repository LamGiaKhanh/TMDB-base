//
//  QueueManager.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/16/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation

class QueueManager {
    let operationQueue = OperationQueue()
    lazy var operationList = SafeDictionary<String, WorkerOperation>()

    var maxConcurrentRequest: Int {
        get {
            operationQueue.maxConcurrentOperationCount
        }
        set {
            operationQueue.maxConcurrentOperationCount = newValue
        }
    }

    var qualityOfService: QualityOfService {
        get {
            operationQueue.qualityOfService
        }
        set {
            operationQueue.qualityOfService = newValue
        }
    }

    var isSuspended: Bool {
        get {
            operationQueue.isSuspended
        }
        set {
            operationQueue.isSuspended = newValue
        }
    }

    func cancelAllRequest() {
        operationQueue.cancelAllOperations()
        operationList.removeAll()
    }
}
