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

struct PokemonSpecie {
    
    let name: String
    
}
