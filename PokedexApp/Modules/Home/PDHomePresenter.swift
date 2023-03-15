//
//  PDHomePresenter.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

protocol PDHomePresenterProtocol: AnyObject {
    
    var pokemonListSize: Int { get }
    func getPokemon(at index: Int) -> Pokemon
    func retrievePokemonList()
    func didTapPokemon(with index: Int)
    func goToSearchPokemon()
    
}

final class PDHomePresenter {
    
    // MARK: - Properties
    
    private weak var view: PDHomeViewProtocol?
    private var interactor: PDHomeInteractorProtocol
    private var router: PDHomeRouterProtocol
    private var pokemonList: [Pokemon] = []
    
    // MARK: - Lifecycle
    
    init(view: PDHomeViewProtocol, interactor: PDHomeInteractorProtocol, router: PDHomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - PDHomePresenterProtocol

extension PDHomePresenter: PDHomePresenterProtocol {
    
    var pokemonListSize: Int { pokemonList.count }
    
    func getPokemon(at index: Int) -> Pokemon {
        return pokemonList[index]
    }
    
    func retrievePokemonList() {
        self.view?.showLoading()
        interactor.retrievePokemonList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pokemonResult):
                let pokemons = pokemonResult.pokemons
                if !pokemons.isEmpty {
                    self.pokemonList = pokemons
                    pokemons.enumerated().forEach { (index, pokemon) in
                        self.interactor.retrievePokemonDetails(by: pokemon) { [weak self] result in
                            guard let self = self else { return }
                            switch result {
                            case .success(let pokemonDetail):
                                self.pokemonList[index].detail = pokemonDetail
                                if (index+1) == self.pokemonListSize {
                                    self.view?.hideLoading()
                                    self.view?.reloadCollectionView()
                                }
                            case .failure: break
                            }
                        }
                    }
                } else {
                    self.view?.hideLoading()
                    self.view?.showEmpty()
                    self.pokemonList = []
                }
            case .failure(let error):
                self.view?.hideLoading()
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
                self.view?.showError(errorType: errorType)
            }
        }
    }
    
    func didTapPokemon(with index: Int) {
        self.view?.showProgressIndicator()
        var currentPokemon = pokemonList[index]
        interactor.retrievePokemonDescripion(by: index) { [weak self] descriptionResult in
            guard let self = self else { return }
            switch descriptionResult {
            case .success(let description):
                currentPokemon.description = description.description
                self.interactor.retrievePokemonHabitat(by: currentPokemon) { [weak self] habitatResult in
                    guard let self = self else { return }
                    switch habitatResult {
                    case .success(let habitat):
                        currentPokemon.habitat = habitat
                        self.interactor.retrievePokemonEvolutions(by: currentPokemon) { [weak self] evolutionResult in
                            guard let self = self else { return }
                            self.view?.hideProgressIndicator()
                            switch evolutionResult {
                            case .success(let evolution):
                                currentPokemon.evolution = evolution
                                self.router.routeToPokemonDetail(pokemon: currentPokemon)
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
                                self.view?.showError(errorType: errorType)
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
                        self.view?.showError(errorType: errorType)
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
                self.view?.showError(errorType: errorType)
            }
        }
        
        
        
        
    }
    
    func goToSearchPokemon() {
        self.router.routeToSearchPokemon()
    }
    
}
