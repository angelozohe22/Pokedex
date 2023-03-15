//
//  PokemonListRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public struct PokemonListRequest: GetRequest {
    
    // MARK: - Alias
    
    public typealias Response = PokemonListResponse
    
    // MARK: - Properties
    
    public var body: PDEmptyRequest = PDEmptyRequest()
    
    public var baseURL: String { PDEnvironment.Environment.prod.baseUrl }
    
    public var service: String { PDServiceType.pokemon.rawValue }
    
    public var headers: [HeaderKey : String] { PDHeaders.getHeaders() }
    
    // MARK: - Lifecycle
    
    public init() {}
    
}

public struct PokemonListResponse: Decodable {
    
    public let results: [PokemonResponse]
    
}

public struct PokemonResponse: Decodable {
    
    public let name : String
    public let url: String
    
}
