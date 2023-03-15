//
//  PDHomeRemoteRepository.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import PDNetworking

protocol PDHomeRemoteRepositoryProtocol {
    
    func getPokemonList(completion: @escaping (Result<PokemonListResponse, NetworkingError>) -> Void)
    func getPokemonDetails(by index: Int, completion: @escaping (Result<PokemonDetailResponse, NetworkingError>) -> Void)
    func getPokemonHabitat(by index: Int, completion: @escaping (Result<PokemonHabitatResponse, NetworkingError>) -> Void)
    func getPokemonEvolution(by index: Int, completion: @escaping (Result<PokemonEvolutionResponse, NetworkingError>) -> Void)
    func getPokemonDescription(completion: @escaping (Result<[PokemonDescriptionDetailResponse], NetworkingError>) -> Void)
    
}

final class PDHomeRemoteRepository: PDHomeRemoteRepositoryProtocol  {
    
    func getPokemonList(completion: @escaping (Result<PokemonListResponse, NetworkingError>) -> Void) {
        let request = PokemonListRequest()
        let parameters = [
            "offset": "0",
            "limit": "151"
        ]
        RestClient.shared.request(request, parameters: parameters, completion: completion)
    }
    
    func getPokemonDetails(by index: Int, completion: @escaping (Result<PokemonDetailResponse, NetworkingError>) -> Void) {
        let request = PokemonDetailRequest(index: index)
        RestClient.shared.request(request, completion: completion)
    }
    
    func getPokemonHabitat(by index: Int, completion: @escaping (Result<PokemonHabitatResponse, NetworkingError>) -> Void) {
        let request = PokemonHabitatRequest(index: index)
        RestClient.shared.request(request, completion: completion)
    }
    
    func getPokemonEvolution(by index: Int, completion: @escaping (Result<PokemonEvolutionResponse, NetworkingError>) -> Void) {
        let request = PokemonEvolutionRequest(index: index)
        RestClient.shared.request(request, completion: completion)
    }
    
    func getPokemonDescription(completion: @escaping (Result<[PokemonDescriptionDetailResponse], NetworkingError>) -> Void) {
        let request = PokemonDescriptionRequest()
        RestClient.shared.request(request, completion: completion)
    }
    
}
