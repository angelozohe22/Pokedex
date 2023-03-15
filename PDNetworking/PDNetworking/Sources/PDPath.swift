//
//  PDPath.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public enum PDPath {
    
    case pokemonId(Int)
    case pokemonName(String)
    case none
    
    public var path: String {
        
        switch self {
        case .pokemonId(let id):
            return "/\(id)/"
        case .pokemonName(let name):
            return "/\(name)/"
        case .none:
            return ""
        }
        
    }
    
}
