//
//  DownloadManager.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/15/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Alamofire
import Foundation

final class DownloadManager: QueueManager {
    override private init() {}
    static let instance = DownloadManager()

    func addOperation(request: DownloadRequest, responseHandler: @escaping (AFDownloadResponse<URL?>) -> Void) -> Cancellable {
        // 1. Create UUID for each Operation
        let operationID = UUID().uuidString
        log("New Download Operation (\(operationID))")
        // 2. Create DownloadOperator
        let operation = WorkerOperation(id: operationID, mainTask: { finishBlock in
            request.response { [weak self] dataResponse in
                finishBlock()
                // 3. When Operation completed
                //      - Execute callback
                //      - Remove completed Operation
                responseHandler(dataResponse)
                self?.operationList.removeValue(forKey: operationID)
            }
        }, cancelTask: {
            self.remove(operationID: operationID)
            request.cancel()
        })
        // 4. Add Operation into operationQueue
        operationQueue.addOperation(operation)
        // 5. Save Operation into operationList, using for cancel
        operationList[operationID] = operation
        return Cancellable(operation: operation)
    }

    func remove(operationID: String) {
        operationList.removeValue(forKey: operationID)
    }
}
