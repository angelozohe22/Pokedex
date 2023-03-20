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
        let fetchRequest: NSFetchRequest<T_pokemon> = T_pokemon.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do {
            // Fetch request
            let result = try bdContext.fetch(fetchRequest)
            guard let pokemon = result.first else {
                completion(.failure(.unexpectedErrorLoadData))
                return
            }
            // Get information
            guard let name = pokemon.name,
                  let url = pokemon.url,
                  let imageUrl = pokemon.image_url else {
                completion(.failure(.unexpectedErrorLoadData))
                return
            }
            let id = pokemon.id
            let pokemonDetail = try? JSONDecoder().decode(PokemonDetailDto.self, from: (pokemon.pokemon_detail?.data(using: .utf8) ?? Data()))
            // Return data
            completion(.success(PokemonDto(id: Int(id), name: name, url: url, imageUrl: imageUrl, detail: pokemonDetail)))
        } catch {
            completion(.failure(.unexpectedErrorLoadData))
        }
    }
    
    func updatePokemon(pokemon: PokemonDto, completion: (Result<Bool, PokemonError>) -> Void) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "T_pokemon")
        fetchRequest.predicate = NSPredicate(format: "id ==\(pokemon.id)")
        do {
            // Fetch request
            let result = try bdContext.fetch(fetchRequest)
            guard let objUpdate = result.first as? NSManagedObject else {
                return
            }
            // Update data into bd oject
            guard let pokemonDetailData = try? JSONEncoder().encode(pokemon.detail),
                  let pokemonDetailString = String(data: pokemonDetailData, encoding: .utf8) else {
                return
            }
            objUpdate.setValue(pokemon.name, forKey: "name")
            objUpdate.setValue(pokemon.url, forKey: "url")
            objUpdate.setValue(pokemon.imageUrl, forKey: "image_url")
            objUpdate.setValue(pokemonDetailString, forKey: "pokemon_detail")
            // Save data
            try bdContext.save()
        } catch let error as NSError {
            print("---->> Error update pokemon : \(error)")
        }
    }
    
}
