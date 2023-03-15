//
//  PDPokemonDetailPresenter.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

protocol PDPokemonDetailPresenterProtocol: AnyObject {
    
    func goToParent()
    func retrievePokemonData()
    
}

final class PDPokemonDetailPresenter {

    // MARK: - Properties
    
    private weak var view: PDPokemonDetailView?
    private var interactor: PDPokemonDetailInteractorProtocol
    private var router: PDPokemonDetailRouterProtocol
    private var pokemon: Pokemon!
    
    // MARK: - Lifecycle
    
    init(view: PDPokemonDetailView, interactor: PDPokemonDetailInteractorProtocol, router: PDPokemonDetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Functions
    
    @discardableResult
    func set(pokemon: Pokemon) -> PDPokemonDetailPresenterProtocol {
        self.pokemon = pokemon
        return self
    }

}

// MARK: - PDPokemonDetailPresenterProtocol

extension PDPokemonDetailPresenter: PDPokemonDetailPresenterProtocol {
    
    func retrievePokemonData() {
        self.view?.setValue(pokemon: pokemon)
    }
    
    func goToParent() {
        router.routeToParent()
    }
    
}
