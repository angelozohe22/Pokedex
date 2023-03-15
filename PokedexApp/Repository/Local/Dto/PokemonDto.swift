//
//  PokemonDto.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

struct PokemonDto: Codable {
    
    let id: Int
    let name: String
    let url: String
    let imageUrl: String
    var detail: PokemonDetailDto? = nil
    
}

struct PokemonDetailDto: Codable {
    
    let height: Int
    let weight: Int
    var abilities: [PokemonDetailAbilityDto]? = nil
    var stats: [PokemonDetailStatDto]? = nil
    var types: [PokemonDetailTypeDto]? = nil
    var habitat: PokemonDetailHabitatDto? = nil
    var evolution: PokemonEvolutionDto? = nil
    
}

struct PokemonDetailAbilityDto: Codable {
    
    let name: String
    
}

struct PokemonDetailStatDto: Codable {
    
    let baseStat: Int
    let effort: Int
    let statName: String
    
}

struct PokemonDetailTypeDto: Codable {
    
    let name: String
    
}

struct PokemonDetailHabitatDto: Codable {
    
    let id: String
    let name: String
    
}

struct PokemonEvolutionDto: Codable {
    
    let chain: PokemonEvolvesDto
    
}

struct PokemonEvolvesDto: Codable {
    
    let specie: PokemonSpecieDto
    let evolvesTo: [PokemonEvolvesDto]
    
}

struct PokemonSpecieDto: Codable {
    
    let name: String
    
}

