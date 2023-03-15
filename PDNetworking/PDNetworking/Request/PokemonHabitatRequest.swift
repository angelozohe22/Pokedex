//
//  PokemonHabitatRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

public struct PokemonHabitatRequest: GetRequest {
    
    // MARK: - Alias
    
    public typealias Response = PokemonHabitatResponse
    
    // MARK: - Properties
    
    public var body: PDEmptyRequest = PDEmptyRequest()
    
    public var baseURL: String { PDEnvironment.Environment.prod.baseUrl }
    
    public var service: String { PDServiceType.habitat.rawValue }
    
    public var headers: [HeaderKey : String] { PDHeaders.getHeaders() }
    
    let index: Int
    
    // MARK: - Lifecycle
    
    public init(index: Int) {
        self.index = index
    }
    
}

extension PokemonHabitatRequest {
    
    public var path: String { PDPath.pokemonId(index).path }
    
}

public struct PokemonHabitatResponse: Decodable {
    
    public let id: Int
    public let name: String
    
}
