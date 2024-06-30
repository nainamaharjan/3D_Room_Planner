//
//  HTTPClient.swift
//  anydone_inbox
//
//  Created by Naina Maharjan on 9/28/21.
//

import Foundation

public protocol HTTPClient {
   
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL, token: String?, completion: @escaping (Result) -> Void)
    func upload(_ data: Data, token: String?, with boundary: String, to url: URL, completion: @escaping (Result) -> Void, progressMade: @escaping (Double) -> Void)
    func post(_ data: Data, to url: URL, token: String?, completion: @escaping (Result) -> Void)
    func post(to url: URL, token: String?, completion: @escaping (Result) -> Void)
    func patch(to url: URL, token: String?, completion: @escaping (Result) -> Void)
    func patch(to url: URL, data: Data, token: String?, completion: @escaping (Result) -> Void)
    func put(to url: URL, token: String?, completion: @escaping (Result) -> Void)
    func put(to url: URL, data: Data, token: String?, completion: @escaping (Result) -> Void)
    func delete(to url: URL, token: String?, completion: @escaping (Result) -> Void)
    func delete(to url: URL, data: Data, token: String?, completion: @escaping (Result) -> Void)
    
}
