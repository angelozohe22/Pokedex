//
//  PokemonEvolutionRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

public struct PokemonEvolutionRequest: GetRequest {
    
    // MARK: - Alias
    
    public typealias Response = PokemonEvolutionResponse
    
    // MARK: - Properties
    
    public var body: PDEmptyRequest = PDEmptyRequest()
    
    public var baseURL: String { PDEnvironment.Environment.prod.baseUrl }
    
    public var service: String { PDServiceType.evolution.rawValue }
    
    public var headers: [HeaderKey : String] { PDHeaders.getHeaders() }
    
    let index: Int
    
    // MARK: - Lifecycle
    
    public init(index: Int) {
        self.index = index
    }
    
}

extension PokemonEvolutionRequest {
    
    public var path: String { PDPath.pokemonId(index).path }
    
}
public struct PokemonEvolutionResponse: Decodable {

    public let chain: PokemonEvolvesResponse

}

public struct PokemonEvolvesResponse: Decodable {

    public let species: PokemonSpecieResponse
    public let evolvesTo: [PokemonEvolvesResponse]

    enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
    }

}

public struct PokemonSpecieResponse: Decodable {

    public let name: String

}
