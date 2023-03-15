//
//  PokemonSpeciesRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import Foundation

public struct PokemonSpeciesRequest: GetRequest {
    
    // MARK: - Alias
    
    public typealias Response = PokemonSpeciesResponse
    
    // MARK: - Properties
    
    public var body: PDEmptyRequest = PDEmptyRequest()
    
    public var baseURL: String { PDEnvironment.Environment.prod.baseUrl }
    
    public var service: String { PDServiceType.specie.rawValue }
    
    public var headers: [HeaderKey : String] { PDHeaders.getHeaders() }
    
    let index: Int
    
    // MARK: - Lifecycle
    
    public init(index: Int) {
        self.index = index
    }
    
}

extension PokemonSpeciesRequest {
    
    public var path: String { PDPath.pokemonId(index).path }
    
}

public struct PokemonSpeciesResponse: Decodable {
    
    public let habitat: PokemonHabitatNameResponse
    public let evolvesFrom: PokemonEvolutionFromResponse?
    
    enum CodingKeys: String, CodingKey {
        case habitat
        case evolvesFrom = "evolves_from_species"
    }
    
}

public struct PokemonHabitatNameResponse: Decodable {
    
    public let name: String
    
}

public struct PokemonEvolutionFromResponse: Decodable {
    
    public let name: String
    
}

