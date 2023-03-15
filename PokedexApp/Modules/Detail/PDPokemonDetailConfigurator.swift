//
//  PDPokemonDetailConfigurator.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

final class PDPokemonDetailConfigurator {

    // MARK: - Properties
    
    private var viewController: PDPokemonDetailViewController
    private var pokemon: Pokemon!
    
    // MARK: - Lifecycle
    
    init(from viewController: PDPokemonDetailViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    
    @discardableResult
    func set(pokemon: Pokemon) -> PDPokemonDetailConfigurator {
        self.pokemon = pokemon
        return self
    }
    
    func configure() -> PDPokemonDetailPresenter {
        let router = PDPokemonDetailRouter(viewController: self.viewController)
        let localRepository = PDPokemonDetailLocalRepository()
        let remoteRepository = PDPokemonDetailRemoteRepository()
        let interactor = PDPokemonDetailInteractor(localRepository: localRepository,
                                                   remoteRepository: remoteRepository)
        let presenter = PDPokemonDetailPresenter(view: self.viewController,
                                                 interactor: interactor,
                                                 router: router)
        presenter.set(pokemon: self.pokemon)
        return presenter
    }

}
