//
//  RemoteUploader.swift
//  anydone_inbox
//
//  Created by Naina Maharjan on 9/28/21.
//

import Foundation

public enum CustomError: Swift.Error {
    case connectivity
    case invalidData
    case custom(errorCode: Int?, errorDescription: String?)
    
    var localizedDescription: String {
        switch self {
        case  .connectivity: return "Connection Issue, Please check your Internet."
        case  .invalidData: return  "Server Error"
        case let .custom( _, errorMessage): return errorMessage ?? "Unknown Error"
        }
    }
    
}

public class RemoteUploader<Resource> {
    public typealias Result = Swift.Result<Resource, Swift.Error>
    public typealias Mapper = (Data, HTTPURLResponse) throws -> Resource
    
    private let client: HTTPClient
    private let url: URL
    private let mapper: Mapper
    public let token: String?
    
    public init(client: HTTPClient, url: URL, mapper: @escaping Mapper, token: String?) {
        self.client = client
        self.url = url
        self.mapper = mapper
        self.token = token
    }
    
    public func post(data: Data, completion: @escaping (Result) -> Void) {
        client.post(data, to: url, token: token) { [self] result in
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func post(completion: @escaping (Result) -> Void) {
        client.post(to: url, token: token) { [self] result in
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func post(pathParam: String, completion: @escaping (Result) -> Void) {
        let urlWithPathParam = URL(string: url.absoluteString + "\(pathParam)")!
        client.post( to: urlWithPathParam, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    public func patch(pathParam: String, completion: @escaping (Result) -> Void) {
        let urlWithPathParam = URL(string: url.absoluteString + "/\(pathParam)")!
        client.patch( to: urlWithPathParam, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func patch(pathParam: String, data: Data, completion: @escaping (Result) -> Void) {
        let urlWithPathParam = URL(string: url.absoluteString + "/\(pathParam)")!
        client.patch( to: urlWithPathParam, data: data, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func patch(data: Data, completion: @escaping (Result) -> Void) {
        client.patch( to: url, data: data, token: token) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func patch(completion: @escaping (Result) -> Void) {
        client.patch( to: url, token: token) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func put(pathParam: String, completion: @escaping (Result) -> Void) {
        let urlWithPathParam = URL(string: url.absoluteString + "/\(pathParam)")!
        client.put( to: urlWithPathParam, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func put(pathParam: String, data: Data, completion: @escaping (Result) -> Void) {
        let urlWithPathParam = URL(string: url.absoluteString + "/\(pathParam)")!
        client.put( to: urlWithPathParam, data: data, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func put(data: Data, completion: @escaping (Result) -> Void) {
        client.put( to: url, data: data, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func delete(completion: @escaping (Result) -> Void) {
        client.delete( to: url, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func delete(pathParam: String, data: Data, completion: @escaping (Result) -> Void) {
        let urlWithPathParam = URL(string: url.absoluteString + "/\(pathParam)")!
        client.delete( to: urlWithPathParam, data: data, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func delete(pathParam: String, completion: @escaping (Result) -> Void) {
        let urlWithPathParam = URL(string: url.absoluteString + "/\(pathParam)")!
        client.delete( to: urlWithPathParam, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    public func delete(data: Data, completion: @escaping (Result) -> Void) {
        client.delete( to: url, data: data, token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
