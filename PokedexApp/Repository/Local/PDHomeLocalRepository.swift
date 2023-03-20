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
        let fetchRequest: NSFetchRequest<T_pokemon> = T_pokemon.fetchRequest()
        do {
            let results = try bdContext.fetch(fetchRequest)
            let pokemonList = results.compactMap { pokemon -> PokemonDto? in
                guard let name = pokemon.name,
                      let url = pokemon.url,
                      let imageUrl = pokemon.image_url else {
                    return nil
                }
                let id = pokemon.id
                let pokemonDetail = try? JSONDecoder().decode(PokemonDetailDto.self, from: (pokemon.pokemon_detail?.data(using: .utf8) ?? Data()))
                return PokemonDto(id: Int(id), name: name, url: url, imageUrl: imageUrl, detail: pokemonDetail)
            }
            if pokemonList.isEmpty {
                completion(.failure(.noData))
                return
            }
            completion(.success(pokemonList))
        } catch {
            completion(.failure(.unexpectedError))
        }
    }
    
    func insertPokemon(pokemon: PokemonDto) {
        guard let pokemonEntity = NSEntityDescription.entity(forEntityName: "T_pokemon", in: bdContext) else {
            print("---->> Error creating pokemon entity")
            return
        }
        let newPokemon = NSManagedObject(entity: pokemonEntity, insertInto: bdContext)
        newPokemon.setValue(Int(pokemon.id), forKey: "id")
        newPokemon.setValue(pokemon.name, forKey: "name")
        newPokemon.setValue(pokemon.url, forKey: "url")
        newPokemon.setValue(pokemon.imageUrl, forKey: "image_url")
        if let pokemonDetailData = try? JSONEncoder().encode(pokemon.detail),
           let pokemonDetailString = String(data: pokemonDetailData, encoding: .utf8) {
            newPokemon.setValue(pokemonDetailString, forKey: "pokemon_detail")
        }
        // Save Data
        do {
            try bdContext.save()
        } catch {
            print("---->> Error save add pokemon : \(error)")
        }
    }
    
    func updatePokemon(pokemon: PokemonDto) {
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
    
    func getPokemon(by id: Int, completion: (Result<PokemonDto, PokemonError>) -> Void) {
        let fetchRequest: NSFetchRequest<T_pokemon> = T_pokemon.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id ==\(id)")
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
    
}
