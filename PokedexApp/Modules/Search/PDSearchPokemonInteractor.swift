//
//  PDSearchPokemonInteractor.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import Foundation
import PDNetworking

protocol PDSearchPokemonInteractorProtocol {
    
    func retrievePokemon(by name: String, completion: @escaping (Result<Pokemon, NetworkingError>) -> Void)
    func retrievePokemonDescripion(by index: Int, completion: @escaping (Result<PokemonDescription, NetworkingError>) -> Void)
    func retrievePokemonMoreInformation(at index: Int, completion: @escaping (Result<PokemonSpecies, NetworkingError>) -> Void)
    
}

final class PDSearchPokemonInteractor {

    // MARK: - Properties
    
    private var localRepository: PDSearchPokemonLocalRepositoryProtocol
    private var remoteRepository: PDSearchPokemonRemoteRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(localRepository: PDSearchPokemonLocalRepositoryProtocol,
         remoteRepository: PDSearchPokemonRemoteRepositoryProtocol) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
}

// MARK: - PDPokemonDetailInteractorProtocol

extension PDSearchPokemonInteractor: PDSearchPokemonInteractorProtocol {
    
    func retrievePokemon(by name: String, completion: @escaping (Result<Pokemon, NetworkingError>) -> Void) {
        if PDNetworkReachability.shared.isConnected {
            remoteRepository.getPokemonDetails(by: name) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        let pokemon = PokemonResponseMapper.mapDetailResponseToPokemon(response: response)
                        let pokemonDto = PokemonDtoMapper.mapPokemonToPokemonDto(pokemon: pokemon)
                        self.localRepository.updatePokemon(pokemon: pokemonDto) { result in
                            switch result {
                            case .success:
                                completion(.success(pokemon))
                            case .failure:
                                completion(.failure(.noContent))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        } else {
            localRepository.getPokemon(by: name) { result in
                switch result {
                case .success(let response):
                    if let _ = response.detail {
                        let pokemon = PokemonDtoMapper.mapPokemonDtoToPokemon(pokemonDto: response)
                        completion(.success(pokemon))
                    } else { completion(.failure(.noContent)) }
                case .failure:
                    completion(.failure(.noContent))
                }
            }
        }
    }
    
    func retrievePokemonDescripion(by index: Int, completion: @escaping (Result<PokemonDescription, NetworkingError>) -> Void) {
        if !PDNetworkReachability.shared.isConnected {
            completion(.failure(.notConnectionInternet))
        } else {
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
    }
    
    func retrievePokemonMoreInformation(at index: Int, completion: @escaping (Result<PokemonSpecies, NetworkingError>) -> Void) {
        if !PDNetworkReachability.shared.isConnected {
            completion(.failure(.notConnectionInternet))
        } else {
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
    
}
