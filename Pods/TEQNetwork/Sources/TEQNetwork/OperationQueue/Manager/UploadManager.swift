//
//  UploadManager.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/16/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Alamofire
import Foundation

final class UploadManager: QueueManager {
    override private init() {}

    static let instance = UploadManager()

    func addOperation(request: UploadRequest, responseHandler: @escaping (AFDataResponse<Data?>) -> Void) -> Cancellable {
        // 1. Create UUID for each Operation
        let operationID = UUID().uuidString
        // 2. Create DownloadOperator
        let operation = WorkerOperation(id: operationID, mainTask: { finishBlock in
            request.response { dataResponse in
                finishBlock()
                // 3. When Operation completed
                //      - Execute callback
                //      - Remove completed Operation
                responseHandler(dataResponse)
                self.operationList.removeValue(forKey: operationID)
            }
        }, cancelTask: { [weak self] in
            self?.remove(operationID: operationID)
            request.cancel()
        })
//        // 4. Add Operation into operationQueue
        operationQueue.addOperation(operation)
//        // 5. Save Operation into operationList, using for cancel
        operationList[operationID] = operation
        return Cancellable(operation: operation)
    }

    func remove(operationID: String) {
        operationList[operationID]?.cancel()
        operationList.removeValue(forKey: operationID)
    }
}
