//
//  PokemonDetailRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public struct PokemonDetailRequest: GetRequest {
    
    // MARK: - Alias
    
    public typealias Response = PokemonDetailResponse
    
    // MARK: - Properties
    
    public var body: PDEmptyRequest = PDEmptyRequest()
    
    public var baseURL: String { PDEnvironment.Environment.prod.baseUrl }
    
    public var service: String { PDServiceType.pokemon.rawValue }
    
    public var headers: [HeaderKey : String] { PDHeaders.getHeaders() }
    
    var index: Int? = nil
    
    var name: String? = nil
    
    // MARK: - Lifecycle
    
    public init(index: Int) {
        self.index = index
    }
    
    public init(name: String) {
        self.name = name
    }
    
}

extension PokemonDetailRequest {
    
    public var path: String {
        if let index = index {
            return PDPath.pokemonId(index).path
        }
        if let name = name {
            return PDPath.pokemonName(name).path
        }
        return PDPath.none.path
    }
    
}

public struct PokemonDetailResponse: Decodable {
    
    public let id: Int
    public let name: String
    public let abilities: [PokemonAbilityResponse]
    public let height: Int
    public let stats: [PokemonStatResponse]
    public let types: [PokemonTypeResponse]
    public let weight: Int
    public var url: String {
        return "\(PDEnvironment.Environment.prod.baseUrl)\(PDServiceType.pokemon.rawValue)/\(id)/"
    }
    
}

public struct PokemonAbilityResponse: Decodable {
    
    public let ability: PokemonAbility
    
}

public struct PokemonAbility: Decodable {
    
    public let name: String
    
}

public struct PokemonStatResponse: Decodable {
    
    public let baseStat: Int
    public let effort: Int
    public let stat: PokemonStat
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
    
}

public struct PokemonStat: Decodable {
    
    public let name: String
    
}

public struct PokemonTypeResponse: Decodable {
    
    public let type: PokemonType
    
}

public struct PokemonType: Decodable {
    
    public let name: String
    
}
