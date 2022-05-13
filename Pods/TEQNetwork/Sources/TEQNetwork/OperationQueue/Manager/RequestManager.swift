//
//  RequestManager.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/16/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Alamofire
import Foundation

typealias DataResponseHandler = (AFDataResponse<Data?>) -> Void

final class RequestManager: QueueManager {
    override private init() {}
    static let instance = RequestManager()
    private lazy var operationRequestMapping = SafeDictionary<String, [String]>() // [OperationID: RequestIDs]
    private lazy var requestCallbackMapping = SafeDictionary<String, DataResponseHandler>() // [RequestID: Callbacks]

    func addOperation(request: DataRequest, responseHandler: @escaping DataResponseHandler) -> Cancellable {
        let operationID = createOperationID(dataRequest: request)
        // Create UUID for each request
        let newRequestID = UUID().uuidString
        log("New Request - (\(newRequestID))")

        if let requestIDs = operationRequestMapping[operationID], !requestIDs.isEmpty, let existedOperation = operationList[operationID] {
            log("Using old Operation \(operationID)")
            // If exist RequestIDs mapping with OperationID
            // 1. append newRequestID into operationRequestMapping
            operationRequestMapping[operationID]?.append(newRequestID)
            // 2. save callback to requestCallbackMapping
            requestCallbackMapping[newRequestID] = responseHandler
            return Cancellable(operation: existedOperation)
        } else {
            log("New Request Operation (\(operationID))")
            // If OperationID don't have any RequestIDs
            // 1. Create mapping between OperationID and RequestID
            operationRequestMapping[operationID] = [newRequestID]
            // 2. Save callback to requestCallbackMapping
            requestCallbackMapping[newRequestID] = responseHandler
            // 3. Create RequestOperation
            let requestOperation = WorkerOperation(id: operationID, mainTask: { finishTask in
                request.response { [weak self] dataResponse in
                    finishTask()
                    // 4. When Operation completed
                    //      - Execute all callbacks
                    //      - Remove completed RequestOperation
                    self?.operationRequestMapping[operationID]?.forEach { id in
                        self?.requestCallbackMapping[id]?(dataResponse)
                    }
                    self?.removeCompletedOperation(id: operationID)
                }
            }, cancelTask: { [weak self] in
                // Remove RequestID
                var requests = self?.operationRequestMapping[operationID]
                requests?.removeAll(where: { (id) -> Bool in
                    id == newRequestID
                })
                if requests?.isEmpty ?? false {
                    // If no request mapping with OperationID, remove OperationID and operation
                    self?.operationRequestMapping.removeValue(forKey: operationID)
                    // Cancel unuse operation
                    self?.operationList[operationID]?.cancel()
                    self?.operationList.removeValue(forKey: operationID)
                    request.cancel()
                } else {
                    // Assign remaining RequestID
                    self?.operationRequestMapping[operationID] = requests
                }
                // Remove all callback mapping with RequestID
                self?.requestCallbackMapping.removeValue(forKey: newRequestID)
            })
            // 5. Add RequestOperation into operationQueue
            operationQueue.addOperation(requestOperation)
            // 6. Save RequestOperation into operationList, using for cancel
            operationList[operationID] = requestOperation
            return Cancellable(operation: requestOperation)
        }
    }

    private func createOperationID(dataRequest: DataRequest) -> String {
        guard let currentRequest = dataRequest.convertible.urlRequest else { return String(dataRequest.hashValue) }
//        print("\(String(describing: currentRequest.url)) + \(String(describing: currentRequest.method)) + \(String(describing: currentRequest.allHTTPHeaderFields)) + \(String(describing: currentRequest.httpBody))")
        var hasher = Hasher()
        hasher.combine(currentRequest.url)
        hasher.combine(currentRequest.method)
        hasher.combine(currentRequest.allHTTPHeaderFields)
        hasher.combine(currentRequest.httpBody)
        return String(hasher.finalize())
    }

    private func removeCompletedOperation(id: String) {
        // Remove operation
        operationList.removeValue(forKey: id)
        // remove all RequestIDs mapping with this OperationID
        let requestIDs = operationRequestMapping[id]
        operationRequestMapping.removeValue(forKey: id)
        // Remove all callback mapping with just removed RequestIDs
        requestIDs?.forEach { requestID in
            requestCallbackMapping.removeValue(forKey: requestID)
        }
    }

    override func cancelAllRequest() {
        super.cancelAllRequest()
        operationRequestMapping.removeAll()
        requestCallbackMapping.removeAll()
    }
}
