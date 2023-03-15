//
//  PDPokemonDetailInteractor.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

protocol PDPokemonDetailInteractorProtocol {
    
}

final class PDPokemonDetailInteractor {

    // MARK: - Properties
    
    private var localRepository: PDPokemonDetailLocalRepositoryProtocol
    private var remoteRepository: PDPokemonDetailRemoteRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(localRepository: PDPokemonDetailLocalRepositoryProtocol,
         remoteRepository: PDPokemonDetailRemoteRepositoryProtocol) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
}

// MARK: - PDPokemonDetailInteractorProtocol

extension PDPokemonDetailInteractor: PDPokemonDetailInteractorProtocol {
    
    
    
}
