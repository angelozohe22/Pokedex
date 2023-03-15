//
//  PDPokemonDetailLocalRepository.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import UIKit
import CoreData

protocol PDPokemonDetailLocalRepositoryProtocol {
    
}

final class PDPokemonDetailLocalRepository: PDPokemonDetailLocalRepositoryProtocol {
    
    private let bdContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}
