//
//  Networking.swift
//  TEQNetwork
//
//  Created by Nghia Nguyen on 4/7/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift
import Combine

public struct TEQNetwork {
    private let errorReporter: ErrorReportable?
    private let session: Session
    private let decoder: JSONDecoder

    public init(config: NetworkConfig = NetworkConfig.default()) {
        self.decoder = config.decoder
        self.errorReporter = config.errorReporter
        self.session = Session(configuration: config.sessionConfiguration, interceptor: config.interceptor, eventMonitors: config.eventMonitors)
    }

    // MARK: Pure Request

    // Data Request
    @discardableResult
    public func request(_ convertible: URLRequestConvertible, validationType: ValidationType, completion: @escaping (Data?, Error?) -> Void) -> Cancellable {
        var request: DataRequest = session.request(convertible)
        if validationType != .none {
            request = request.validate(statusCode: validationType.statusCodes)
        }

        return RequestManager.instance.addOperation(request: request) { response in
            switch response.result {
            case let .success(data):
                completion(data, nil)
            case let .failure(error):
                self.errorReporter?.report(error: error)
                completion(nil, NetworkError.underlying(error, TEQResponse(response)))
            }
        }
    }

    // Data Download
    @discardableResult
    public func download(_ convertible: URLRequestConvertible, validationType: ValidationType, progress: ProgressHandler? = nil,
                         destination: Destination = DownloadRequest.suggestedDownloadDestination(), completion: @escaping (URL?, Error?) -> Void) -> Cancellable {
        var request: DownloadRequest = session.download(convertible)
        if validationType != .none {
            request = request.validate(statusCode: validationType.statusCodes)
        }
        
        if let progress = progress {
            request = request.downloadProgress(closure: progress)
        }

        return DownloadManager.instance.addOperation(request: request) { response in
            switch response.result {
            case let .success(fileURL):
                completion(fileURL, nil)
            case let .failure(error):
                self.errorReporter?.report(error: error)
                completion(nil, NetworkError.underlying(error, TEQResponse(response)))
            }
        }
    }

    // Data Upload
    @discardableResult
    public func upload(_ convertible: URLRequestConvertible, validationType: ValidationType, multipartFormData: MultipartFormData, progress: ProgressHandler? = nil, completion: @escaping (Data?, Error?) -> Void) -> Cancellable {
        var request = session.upload(multipartFormData: multipartFormData, with: convertible)
        if validationType != .none {
            request = request.validate(statusCode: validationType.statusCodes)
        }
        
        if let progress = progress {
            request = request.uploadProgress(closure: progress)
        }

        return UploadManager.instance.addOperation(request: request) { response in
            switch response.result {
            case let .success(data):
                completion(data, nil)
            case let .failure(error):
                self.errorReporter?.report(error: error)
                completion(nil, NetworkError.underlying(error, TEQResponse(response)))
            }
        }
    }
}

public extension TEQNetwork {
    // MARK: Request with TargetType

    @discardableResult
    func request<T: TargetType>(targetType: T, completion: @escaping (Data?, Error?) -> Void) -> Cancellable {
        return sendRequest(targetType: targetType) { data, _, error in
            completion(data, error)
        }
    }

    @discardableResult
    func download<T: TargetType>(targetType: T, progress: ProgressHandler? = nil, completion: @escaping (URL?, Error?) -> Void) -> Cancellable {
        return sendRequest(targetType: targetType, progress: progress) { _, url, error in
            completion(url, error)
        }
    }

    @discardableResult
    func upload<T: TargetType>(targetType: T, progress: ProgressHandler? = nil, completion: @escaping (Data?, Error?) -> Void) -> Cancellable {
        return sendRequest(targetType: targetType, progress: progress) { data, _, error in
            completion(data, error)
        }
    }

    @discardableResult
    private func sendRequest<T: TargetType>(targetType: T, progress: ProgressHandler? = nil, completion: @escaping (Data?, URL?, Error?) -> Void) -> Cancellable {
        switch targetType.task {
        case let .downloadDestination(destination), let .downloadParameters(_, _, destination):
            let endpoint = Endpoint(targetType: targetType)
            return download(endpoint, validationType: targetType.validationType, progress: progress, destination: destination) { url, error in
                completion(nil, url, error)
            }
        case let .uploadMultipart(multipartBody), let .uploadCompositeMultipart(multipartBody, _):
            let endpoint = Endpoint(targetType: targetType)
            return upload(endpoint, validationType: targetType.validationType, multipartFormData: multipartBody, progress: progress) { data, error in
                completion(data, nil, error)
            }
        case .requestPlain, .requestJSONEncodable, .requestCustomJSONEncodable, .requestParameters, .requestCompositeParameters:
            let endpoint = Endpoint(targetType: targetType)
            return request(endpoint, validationType: targetType.validationType) { data, error in
                completion(data, nil, error)
            }
        }
    }
}

public extension TEQNetwork {
    // MARK: Support Codable Response

    @discardableResult
    func request<T, H>(targetType: T, completion: @escaping (Result<H, Error>) -> Void) -> Cancellable where T: TargetType, H: Decodable {
        return request(targetType: targetType) { data, error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(self.decodeResponse(data: data, atKeyPath: targetType.keyPath))
            }
        }
    }

    @discardableResult
    func upload<T, H>(targetType: T, progress: ProgressHandler? = nil, completion: @escaping (Result<H, Error>) -> Void) -> Cancellable where T: TargetType, H: Decodable {
        return upload(targetType: targetType, progress: progress) { data, error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(self.decodeResponse(data: data, atKeyPath: targetType.keyPath))
            }
        }
    }
}

public extension TEQNetwork {
    // MARK: Support Reactive Programming

    func rxRequest<T, H>(targetType: T, atKeyPath keyPath: String? = nil) -> Observable<H> where T: TargetType, H: Decodable {
        return Observable<H>.create { (observer) -> Disposable in
            let cancelable = self.request(targetType: targetType) { (result: Result<H, Error>) in
                switch result {
                case let .success(object):
                    observer.onNext(object)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                cancelable.cancel()
            }
        }
    }

    func rxDownload<T>(targetType: T, progress: ProgressHandler? = nil) -> Observable<URL> where T: TargetType {
        return Observable<URL>.create { (observer) -> Disposable in
            let cancelable = self.download(targetType: targetType, progress: progress) { url, error in
                if let err = error {
                    observer.onError(err)
                } else {
                    observer.onNext(url!)
                    observer.onCompleted()
                }
            }
            return Disposables.create {
                cancelable.cancel()
            }
        }
    }

    func rxUpload<T, H>(targetType: T, atKeyPath keyPath: String? = nil, progress: ProgressHandler? = nil) -> Observable<H> where T: TargetType, H: Decodable {
        return Observable<H>.create { (observer) -> Disposable in
            let cancelable = self.upload(targetType: targetType, progress: progress) { (result: Result<H, Error>) in
                switch result {
                case let .success(object):
                    observer.onNext(object)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                cancelable.cancel()
            }
        }
    }
}

@available(iOS 15.0.0, *)
public extension TEQNetwork {
    // MARK: Support async/await

    private actor TEQNetworkActor<T> {
        private var cancellable: Cancellable?
        private var continuation: CheckedContinuation<T, Error>?

        deinit {
            print("TEQNetworkActor deinit")
        }

        func execute(with continuation: CheckedContinuation<T, Error>, task: () -> Cancellable) {
            self.continuation = continuation
            self.cancellable = task()
        }

        func cancel() {
            cancellable?.cancel()
            continuation?.resume(with: .failure(CancellationError()))
        }
    }

    private func requestWithTaskCancellationHandler<T>(_ task: @escaping (CheckedContinuation<T, Error>) -> Cancellable) async throws -> T {
        let actor = TEQNetworkActor<T>()
        return try await withTaskCancellationHandler(operation: {
            try await withCheckedThrowingContinuation { continuation in
                _Concurrency.Task {
                    await actor.execute(with: continuation, task: {
                        task(continuation)
                    })
                }
            }
        }, onCancel: {
            _Concurrency.Task {
                await actor.cancel()
            }
        })
    }

    func request<T, H>(targetType: T, atKeyPath keyPath: String? = nil) async throws -> H where T: TargetType, H: Decodable {
        return try await requestWithTaskCancellationHandler { continuation in
            self.request(targetType: targetType) { (result: Result<H, Error>) in
                switch result {
                case let .success(object):
                    continuation.resume(with: .success(object))
                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }

    func download<T>(targetType: T, progress: ProgressHandler? = nil) async throws -> URL where T: TargetType {
        return try await requestWithTaskCancellationHandler { continuation in
            self.download(targetType: targetType, progress: progress) { url, error in
                if let err = error {
                    continuation.resume(with: .failure(err))
                } else {
                    continuation.resume(with: .success(url!))
                }
            }
        }
    }

    func upload<T, H>(targetType: T, atKeyPath keyPath: String? = nil, progress: ProgressHandler? = nil) async throws -> H where T: TargetType, H: Decodable {
        return try await requestWithTaskCancellationHandler { continuation in
            self.upload(targetType: targetType, progress: progress) { (result: Result<H, Error>) in
                switch result {
                case let .success(object):
                    continuation.resume(with: .success(object))
                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

extension TEQNetwork {
    // MARK: Helper

    private func decodeResponse<H: Decodable>(data: Data?, atKeyPath keyPath: String? = nil) -> Result<H, Error> {
        do {
            let resultObject: H
            if let keyPath = keyPath {
                resultObject = try decoder.decode(H.self, from: data ?? Data(), keyPath: keyPath)
            } else {
                resultObject = try decoder.decode(H.self, from: data ?? Data())
            }
            return .success(resultObject)
        } catch {
            self.errorReporter?.report(error: error)
            return .failure(NetworkError.objectMapping(error, nil))
        }
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension TEQNetwork {
    // MARK: Support Combine

    func requestPublisher<T, H>(targetType: T, atKeyPath keyPath: String? = nil) -> AnyPublisher<H, Error> where T: TargetType, H: Decodable {
        return TEQNetworkPublisher { subscriber in
            self.request(targetType: targetType) { (result: Result<H, Error>) in
                switch result {
                case let .success(object):
                    _ = subscriber.receive(object)
                    subscriber.receive(completion: .finished)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func downloadPublisher<T>(targetType: T, progress: ProgressHandler? = nil) -> AnyPublisher<URL, Error> where T: TargetType {
        return TEQNetworkPublisher { subscriber in
            self.download(targetType: targetType, progress: progress) { url, error in
                if let err = error {
                    subscriber.receive(completion: .failure(err))
                } else {
                    _ = subscriber.receive(url!)
                    subscriber.receive(completion: .finished)
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func uploadPublisher<T, H>(targetType: T, atKeyPath keyPath: String? = nil, progress: ProgressHandler? = nil) -> AnyPublisher<H, Error> where T: TargetType, H: Decodable {
        return TEQNetworkPublisher { subscriber in
            self.upload(targetType: targetType, progress: progress) { (result: Result<H, Error>) in
                switch result {
                case let .success(object):
                    _ = subscriber.receive(object)
                    subscriber.receive(completion: .finished)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
struct TEQNetworkPublisher<Output, Failure: Error>: Publisher {
    private class TEQNetworkSubscription: Subscription {
        private let task: () -> Cancellable?
        private var cancellable: Cancellable?

        init(task: @escaping () -> Cancellable?) {
            self.task = task
        }

        func request(_ demand: Subscribers.Demand) {
            guard demand > .none else { return }
            cancellable = task()
        }

        func cancel() {
            cancellable?.cancel()
        }
    }

    let callback: (AnySubscriber<Output, Failure>) -> Cancellable?

    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = TEQNetworkSubscription {
            callback(AnySubscriber(subscriber))
        }
        subscriber.receive(subscription: subscription)
    }
}
