//
//  PDEnvironment.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public class PDEnvironment {
    
    public enum Environment {
        
        case prod
        case dev
        
        public var baseUrl: String {
            switch self {
            case .prod:
                return "https://pokeapi.co/api/v2"
            case .dev:
                return "https://pokeapi.co/api/v2"
            }
        }
        
        public var firebaseBaseUrl: String {
            switch self {
            case .prod:
                return "https://pokedex-bb36f.firebaseio.com"
            case .dev:
                return "https://pokedex-bb36f.firebaseio.com"
            }
        }
        
    }
    
    public static func getPokemonImageUrl(at index: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(index).png"
    }
    
}
