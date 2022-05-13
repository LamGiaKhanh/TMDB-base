//
//  TEQNetworkQueueManager.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/20/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Alamofire
import Foundation

public enum QueueType: CaseIterable {
    case request
    case download
    case upload
}

public struct QueueInfo {
    public init(maxConcurrentCount: Int = 5, qualityOfService: QualityOfService = .utility) {
        self.maxConcurrentCount = maxConcurrentCount
        self.qualityOfService = qualityOfService
    }

    let maxConcurrentCount: Int
    let qualityOfService: QualityOfService
}

public final class TEQNetworkQueueManager {
    public struct Config {
        public init(request: QueueInfo = QueueInfo(), download: QueueInfo = QueueInfo(), upload: QueueInfo = QueueInfo()) {
            self.request = request
            self.download = download
            self.upload = upload
        }

        let request: QueueInfo
        let download: QueueInfo
        let upload: QueueInfo

        public static let `default` = Config()
    }

    public static let instance = TEQNetworkQueueManager()
    let networkReachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    private let queueManagers = [RequestManager.instance, UploadManager.instance, DownloadManager.instance]

    private init() {
        networkReachabilityManager?.startListening(onUpdatePerforming: { status in
            log("TEQNetworkQueueManager - \(status)")
        })
    }

    public func config(_ config: Config) {
        let configs = [config.request, config.upload, config.download]
        zip(configs, queueManagers).forEach { update(with: $0.0, on: $0.1) }
    }

    private func update(with info: QueueInfo, on queue: QueueManager) {
        if info.maxConcurrentCount > 0 {
            queue.maxConcurrentRequest = info.maxConcurrentCount
        } else {
            log("maxConcurrentCount must great than 0. Fallback to default value")
        }
        queue.qualityOfService = info.qualityOfService
    }
}
