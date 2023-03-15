//
//  PDSearchPokemonRemoteRepository.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import PDNetworking

protocol PDSearchPokemonRemoteRepositoryProtocol {
    
    func getPokemonDetails(by name: String, completion: @escaping (Result<PokemonDetailResponse, NetworkingError>) -> Void)
    func getPokemonDescription(completion: @escaping (Result<[PokemonDescriptionDetailResponse], NetworkingError>) -> Void)
    func getPokemonMoreInformation(at index: Int, completion: @escaping (Result<PokemonSpeciesResponse, NetworkingError>) -> Void)
    
}

final class PDSearchPokemonRemoteRepository: PDSearchPokemonRemoteRepositoryProtocol {
    
    func getPokemonDetails(by name: String, completion: @escaping (Result<PokemonDetailResponse, NetworkingError>) -> Void) {
        let request = PokemonDetailRequest(name: name)
        RestClient.shared.request(request, completion: completion)
    }
    
    func getPokemonDescription(completion: @escaping (Result<[PokemonDescriptionDetailResponse], NetworkingError>) -> Void) {
        let request = PokemonDescriptionRequest()
        RestClient.shared.request(request, completion: completion)
    }
    
    func getPokemonMoreInformation(at index: Int, completion: @escaping (Result<PokemonSpeciesResponse, NetworkingError>) -> Void) {
        let request = PokemonSpeciesRequest(index: index)
        RestClient.shared.request(request, completion: completion)
    }
    
}
