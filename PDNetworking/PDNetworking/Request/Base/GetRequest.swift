//
//  GetRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public protocol GetRequest: EncodableRequest {}

public extension GetRequest {
    
    var method: HTTPMethod { .GET }
    
}
