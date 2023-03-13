//
//  BaseRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public protocol BaseRequest {
    
    // MARK: - Alias
    
    associatedtype Response
    
    // MARK: - Properties
    
    var baseURL: String { get }
    var service: String { get }
    var path: String { get set }
    var method: HTTPMethod { get }
    var headers: [HeaderKey: String] { get }
    
    // MARK: - Functions
    
    func decode(_ data: Data) throws -> Response
    
}

public extension BaseRequest where Response: Decodable {
    
    var path: String { PDPath.none.path }
    
    var headers: [String : String] {
        [:]
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
    
}

public protocol DecodableRequest: BaseRequest where Response: Decodable {}

public protocol EncodableRequest: DecodableRequest {
    
    associatedtype Body: Encodable
    
    var body: Body { get }
    
}
