//
//  PDHomeInteractor.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation
import PDNetworking

protocol PDHomeInteractorProtocol {
    
    func retrievePokemonList(completion: @escaping (Result<PokemonList, NetworkingError>) -> Void)
    func retrievePokemonDetails(by pokemon: Pokemon, completion: @escaping (Result<PokemonDetail, NetworkingError>) -> Void)
    func retrievePokemonDescripion(by index: Int, completion: @escaping (Result<PokemonDescription, NetworkingError>) -> Void)
    func retrievePokemonMoreInformation(at index: Int, completion: @escaping (Result<PokemonSpecies, NetworkingError>) -> Void)
    
}

final class PDHomeInteractor {
    
    // MARK: - Properties
    
    private var localRepository: PDHomeLocalRepositoryProtocol
    private var remoteRepository: PDHomeRemoteRepositoryProtocol
    var pokemoEvolutionList: [PokemonEvolutionResult] = []
    
    
    // MARK: - Lifecycle
    
    init(localRepository: PDHomeLocalRepositoryProtocol,
         remoteRepository: PDHomeRemoteRepositoryProtocol) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
}

// MARK: - PDHomeInteractorProtocol

extension PDHomeInteractor: PDHomeInteractorProtocol {
    
    func retrievePokemonList(completion: @escaping (Result<PokemonList, NetworkingError>) -> Void) {
        if PDNetworkReachability.shared.isConnected {
            remoteRepository.getPokemonList { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        let pokemons = response.results.map { Pokemon(name: $0.name, url: $0.url) }
                        if !pokemons.isEmpty {
                            let pokemonsDto = pokemons.map { PokemonDtoMapper.mapPokemonToPokemonDto(pokemon: $0) }
                            for pokemonDto in pokemonsDto {
                                self.localRepository.insertPokemon(pokemon: pokemonDto)
                            }
                            completion(.success(PokemonList(pokemons: pokemons)))
                        } else { completion(.failure(.noContent)) }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        } else {
            localRepository.getPokemonList { result in
                switch result {
                case .success(let response):
                    if !response.isEmpty {
                        let pokemonList = response.map { Pokemon(name: $0.name, url: $0.url) }
                        completion(.success(PokemonList(pokemons: pokemonList)))
                    } else { completion(.failure(.noContent)) }
                case .failure:
                    completion(.failure(.noContent))
                }
            }
        }
    }
    
    func retrievePokemonDetails(by pokemon: Pokemon, completion: @escaping (Result<PokemonDetail, NetworkingError>) -> Void) {
        if PDNetworkReachability.shared.isConnected {
            remoteRepository.getPokemonDetails(by: pokemon.id ?? 0) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        let pokemonDetail = PokemonResponseMapper.mapPokemonDetailResponseToPokemonDetail(response: response)
                        let pokemonDetailDto = PokemonDtoMapper.mapPokemonDetailToPokemonDetailDto(pokemonDetail: pokemonDetail)
                        self.localRepository.updatePokemon(pokemon: PokemonDto(id: pokemon.id ?? 0,
                                                                               name: pokemon.name,
                                                                               url: pokemon.url,
                                                                               imageUrl: pokemon.imageUrl ?? "",
                                                                               detail: pokemonDetailDto))
                        
                        completion(.success(pokemonDetail))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        } else {
            localRepository.getPokemon(by: pokemon.id ?? 0) { result in
                switch result {
                case .success(let response):
                    if let detail = response.detail {
                        completion(.success(PokemonDtoMapper.mapPokemonDetailDtoToPokemonDetail(pokemonDetailDto: detail)!))
                    } else { completion(.failure(.noContent)) }
                case .failure:
                    completion(.failure(.noContent))
                }
            }
        }
    }
    
    func retrievePokemonDescripion(by index: Int, completion: @escaping (Result<PokemonDescription, NetworkingError>) -> Void) {
        remoteRepository.getPokemonDescription { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let descriptions = PokemonResponseMapper.mapDescriptionResponseToDescription(response: response)
                    completion(.success(descriptions[index]))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func retrievePokemonMoreInformation(at index: Int, completion: @escaping (Result<PokemonSpecies, NetworkingError>) -> Void) {
        remoteRepository.getPokemonMoreInformation(at: index) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let description = PokemonResponseMapper.mapSpeciesResponseToSpecies(response: response)
                    completion(.success(description))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}
