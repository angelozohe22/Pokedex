//
//  PokemonList.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import PDNetworking

struct PokemonList {
    
    let pokemons: [Pokemon]
    
}

struct Pokemon {
    
    let name: String
    let url: String
    
    var id: Int? {
        if let identifier = url.split(separator: "/").last {
            return Int(identifier)
        }
        return nil
    }
    
    var imageUrl: String? {
        guard let id = id else { return nil }
        return PDEnvironment.getPokemonImageUrl(at: id)
    }
    
    var detail: PokemonDetail? = nil
    var habitat: PokemonHabitat? = nil
    var evolution: PokemonEvolution? = nil
    var description: String? = nil
    var habitatName: String? = nil
    var evolvesFrom: PokemonEvolvesFrom? = nil
    
}
