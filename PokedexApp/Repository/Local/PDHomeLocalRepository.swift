//
//  PDHomeLocalRepository.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import CoreData
import UIKit

protocol PDHomeLocalRepositoryProtocol {
    
    func getPokemonList(completion: (Result<[PokemonDto], PokemonError>) -> Void)
    func updatePokemon(pokemon: PokemonDto)
    func insertPokemon(pokemon: PokemonDto)
    func getPokemon(by index: Int, completion: (Result<PokemonDto, PokemonError>) -> Void)
    
}

final class PDHomeLocalRepository: PDHomeLocalRepositoryProtocol {
    
    private let bdContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getPokemonList(completion: (Result<[PokemonDto], PokemonError>) -> Void) {
        var pokemonList: [PokemonDto] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "T_pokemon")
        
        do {
            let result = try bdContext.fetch(fetchRequest)
            if let managedObject = result as? [NSManagedObject] {
                if !managedObject.isEmpty {
                    managedObject.forEach { pokemon in
                        let pokemonDetail = try? JSONDecoder().decode(PokemonDetailDto.self,
                                                                      from: (((pokemon.value(forKey: "pokemon_detail") as? String)?.data(using: .utf8) ?? nil)!))
                        pokemonList.append(
                            PokemonDto(id: pokemon.value(forKey: "id") as? Int ?? 0,
                                       name: pokemon.value(forKey: "name") as! String,
                                       url: pokemon.value(forKey: "url") as! String,
                                       imageUrl: pokemon.value(forKey: "image_url") as! String,
                                       detail: pokemonDetail)
                        )
                    }
                    completion(.success(pokemonList))
                } else { completion(.failure(.noData)) }
            }
        } catch {
            completion(.failure(.unexpectedError))
        }
    }
    
    func insertPokemon(pokemon: PokemonDto) {
        let pokemonEntity = NSEntityDescription.entity(forEntityName: "T_pokemon", in: bdContext)!
        do{
            let newPokemon = NSManagedObject(entity: pokemonEntity, insertInto: bdContext)
            let pokemonDetail = try? JSONEncoder().encode(pokemon.detail)
            newPokemon.setValue(Int(pokemon.id), forKey: "id")
            newPokemon.setValue(pokemon.name, forKey: "name")
            newPokemon.setValue(pokemon.url, forKey: "url")
            newPokemon.setValue(pokemon.imageUrl, forKey: "image_url")
            newPokemon.setValue(pokemonDetail == nil ? nil : String(data: pokemonDetail!, encoding: .utf8)!, forKey: "pokemon_detail")
            do {
                try bdContext.save()
            } catch {
                print("---->> Error save add pokemon : \(error)")
            }
            
        } catch {
            print("---->> Error add pokemon: \(error)")
        }
    }
    
    func updatePokemon(pokemon: PokemonDto) {
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
                } catch {
                    print("---->> Error update pokemon : \(error)")
                }
            }
            
        } catch let error as NSError {
            print("---->> Error update pokemon : \(error)")
        }
    }
    
    func getPokemon(by id: Int, completion: (Result<PokemonDto, PokemonError>) -> Void) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "T_pokemon")
        fetchRequest.predicate = NSPredicate(format: "id ==\(id)")
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
    
}
