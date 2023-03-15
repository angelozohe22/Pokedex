//
//  PDSearchPokemonRouter.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import UIKit
import PDKit

protocol PDSearchPokemonRouterProtocol {
    
    func routeToParent()
    func routeToPokemonDetails(with pokemon: Pokemon)
    
}

final class PDSearchPokemonRouter {

    // MARK: - Properties
    
    private var viewController: UIViewController
    
    // MARK: - Lifecycle
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

}

// MARK: - PDPokemonDetailRouterProtocol

extension PDSearchPokemonRouter: PDSearchPokemonRouterProtocol {
    
    func routeToParent() {
        self.viewController.navigationController?.popViewController(animated: true)
    }
    
    func routeToPokemonDetails(with pokemon: Pokemon) {
        let destinationVC = PDPokemonDetailViewController.storyboardInstance
        destinationVC.configurator.set(pokemon: pokemon)
        self.viewController.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
