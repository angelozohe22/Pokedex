//
//  PokemonEvolution.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

struct PokemonEvolution {
    
    let chain: PokemonEvolves
    
}

struct PokemonEvolves {
    
    let specie: PokemonSpecie
    let evolvesTo: [PokemonEvolves]
    
}

struct PokemonSpecies {
    
    let habitat: String
    let evolvesFrom: String?
    
}

struct PokemonSpecie {
    
    let name: String
    
}

struct PokemonEvolutionResult {
    
    let id: String
    let name: String
    
}
