//
//  PDSearchPokemonPresenter.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import Foundation

protocol PDSearchPokemonPresenterProtocol: AnyObject {
    
    func goToParent()
    func searchPokemon(by name: String)
    func goToPokemonDetail()
    
}

final class PDSearchPokemonPresenter {

    // MARK: - Properties
    
    private weak var view: PDSearchPokemonView?
    private var interactor: PDSearchPokemonInteractorProtocol
    private var router: PDSearchPokemonRouterProtocol
    private var pokemon: Pokemon? = nil
    private var pokemonList: [Pokemon]? = nil
    
    // MARK: - Lifecycle
    
    init(view: PDSearchPokemonView, interactor: PDSearchPokemonInteractorProtocol, router: PDSearchPokemonRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Functions
    
    @discardableResult
    func set(pokemonList: [Pokemon]?) -> PDSearchPokemonPresenterProtocol {
        self.pokemonList = pokemonList
        return self
    }

}

// MARK: - PDPokemonDetailPresenterProtocol

extension PDSearchPokemonPresenter: PDSearchPokemonPresenterProtocol {
    
    func goToParent() {
        router.routeToParent()
    }
    
    func searchPokemon(by name: String) {
        if name.isEmpty {
            pokemon = nil
            view?.showDefaultInformation()
            return
        }
        view?.showLoading()
        interactor.retrievePokemon(by: name) { [weak self] result in
            guard let self = self else { return }
            self.view?.hideLoading()
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon
                self.view?.setPokemonInformation(pokemon: pokemon)
            case .failure(let error):
                self.pokemon = nil
                let errorType: PokemonError
                switch error {
                case .notConnectionInternet:
                    errorType = .noConection
                case .invalidRequestError, .invalidResponse, .noContent ,.parsingError:
                    errorType = .noData
                case .unexpectedError:
                    errorType = .unexpectedError
                case .unauthorized:
                    errorType = .unauthorized
                }
                self.view?.showError(error: errorType)
            }
        }
    }
    
    func goToPokemonDetail() {
        guard var currentPokemon = pokemon else { return }
        view?.showProgressIndicator()
        interactor.retrievePokemonDescripion(by: (currentPokemon.id ?? 0) - 1) { [weak self] descriptionResult in
            guard let self = self else { return }
            switch descriptionResult {
            case .success(let description):
                currentPokemon.description = description.description
                self.interactor.retrievePokemonMoreInformation(at: currentPokemon.id ?? 0) { [weak self] moreInformationResult in
                    guard let self = self else { return }
                    self.view?.hideProgressIndicator()
                    switch moreInformationResult {
                    case .success(let moreInformation):
                        currentPokemon.habitatName = moreInformation.habitat
                        if let pokemonList = self.pokemonList {
                            let pokemonEvolves = pokemonList.first(where: { $0.name == moreInformation.evolvesFrom })
                            if let pokemonEvolves = pokemonEvolves {
                                currentPokemon.evolvesFrom = PokemonEvolvesFrom(id: pokemonEvolves.id ?? 0,
                                                                                name: pokemonEvolves.name,
                                                                                imageUrl: pokemonEvolves.imageUrl ?? "")
                            }
                            self.router.routeToPokemonDetails(with: currentPokemon)
                        } else { self.view?.showError(error: .noData) }
                    case .failure(let error):
                        let errorType: PokemonError
                        switch error {
                        case .notConnectionInternet:
                            errorType = .noConection
                        case .invalidRequestError, .invalidResponse, .noContent ,.parsingError:
                            errorType = .noData
                        case .unexpectedError:
                            errorType = .unexpectedError
                        case .unauthorized:
                            errorType = .unauthorized
                        }
                        self.view?.showError(error: errorType)
                    }
                }
            case .failure(let error):
                self.view?.hideProgressIndicator()
                let errorType: PokemonError
                switch error {
                case .notConnectionInternet:
                    errorType = .noConection
                case .invalidRequestError, .invalidResponse, .noContent ,.parsingError:
                    errorType = .noData
                case .unexpectedError:
                    errorType = .unexpectedError
                case .unauthorized:
                    errorType = .unauthorized
                }
                self.view?.showError(error: errorType)
            }
        }
    }
    
}
