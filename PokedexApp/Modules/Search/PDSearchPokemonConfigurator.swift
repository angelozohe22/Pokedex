//
//  PDSearchPokemonConfigurator.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import Foundation

final class PDSearchPokemonConfigurator {

    // MARK: - Properties
    
    private var viewController: PDSearchPokemonViewController
    private var pokemonList: [Pokemon]? = nil
    
    // MARK: - Lifecycle
    
    init(from viewController: PDSearchPokemonViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    
    @discardableResult
    func set(pokemonList: [Pokemon]) -> PDSearchPokemonConfigurator {
        self.pokemonList = pokemonList
        return self
    }
    
    func configure() -> PDSearchPokemonPresenter {
        let router = PDSearchPokemonRouter(viewController: self.viewController)
        let localRepository = PDSearchPokemonLocalRepository()
        let remoteRepository = PDSearchPokemonRemoteRepository()
        let interactor = PDSearchPokemonInteractor(localRepository: localRepository,
                                                   remoteRepository: remoteRepository)
        let presenter = PDSearchPokemonPresenter(view: self.viewController,
                                                 interactor: interactor,
                                                 router: router)
        presenter.set(pokemonList: pokemonList)
        return presenter
    }

}
