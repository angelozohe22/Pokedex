//
//  PDSearchPokemonLocalRepository.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import CoreData
import UIKit

protocol PDSearchPokemonLocalRepositoryProtocol {
    
    func getPokemon(by name: String, completion: (Result<PokemonDto, PokemonError>) -> Void)
    func updatePokemon(pokemon: PokemonDto, completion: (Result<Bool, PokemonError>) -> Void)
    
}

final class PDSearchPokemonLocalRepository: PDSearchPokemonLocalRepositoryProtocol {
    
    private let bdContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getPokemon(by name: String, completion: (Result<PokemonDto, PokemonError>) -> Void) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "T_pokemon")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do {
            let result = try bdContext.fetch(fetchRequest)
            if result.count > 0 {
                let pokemon = result[0] as! NSManagedObject
                let pokemonDetail = try? JSONDecoder().decode(PokemonDetailDto.self,
                                                              from: (((pokemon.value(forKey: "pokemon_detail") as? String)?.data(using: .utf8) ?? nil)!))
                
                completion(.success(PokemonDto(id: pokemon.value(forKey: "id") as? Int ?? 0,
                                               name: pokemon.value(forKey: "name") as! String,
                                               url: pokemon.value(forKey: "url") as! String,
                                               imageUrl: pokemon.value(forKey: "image_url") as! String,
                                               detail: pokemonDetail)))
            }
        } catch {
            completion(.failure(.unexpectedErrorLoadData))
        }
    }
    
    func updatePokemon(pokemon: PokemonDto, completion: (Result<Bool, PokemonError>) -> Void) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "T_pokemon")
        fetchRequest.predicate = NSPredicate(format: "id ==\(pokemon.id)")
        
        do {
            let result = try bdContext.fetch(fetchRequest)
            if result.count > 0 {
                let objUpdate = result[0] as! NSManagedObject
                let pokemonDetail = try? JSONEncoder().encode(pokemon.detail)
                objUpdate.setValue(pokemon.name, forKey: "name")
                objUpdate.setValue(pokemon.url, forKey: "url")
                objUpdate.setValue(pokemon.imageUrl, forKey: "image_url")
                objUpdate.setValue(pokemonDetail == nil ? nil : String(data: pokemonDetail!, encoding: .utf8)!, forKey: "pokemon_detail")
                do {
                    try bdContext.save()
                    completion(.success(true))
                } catch {
                    completion(.failure(.unexpectedErrorSaveData))
                }
            }
            
        } catch {
            completion(.failure(.unexpectedErrorSaveData))
        }
    }
    
}
