//
//  PostRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public protocol PostRequest: EncodableRequest {}

public extension PostRequest {
    
    var method: HTTPMethod { .POST }
    
}
