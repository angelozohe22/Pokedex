//
//  PDHomeRouter.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit
import PDKit

protocol PDHomeRouterProtocol {
    
    func routeToPokemonDetail(pokemon: Pokemon)
    func routeToSearchPokemon()
    
}

final class PDHomeRouter {
    
    // MARK: - Properties
    
    private var viewController: UIViewController
    
    // MARK: - Lifecycle
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

// MARK: - PDHomeRouterProtocol

extension PDHomeRouter: PDHomeRouterProtocol {
    
    func routeToPokemonDetail(pokemon: Pokemon) {
        let destinationVC = PDPokemonDetailViewController.storyboardInstance
        destinationVC.configurator.set(pokemon: pokemon)
        self.viewController.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToSearchPokemon() {
        
    }
    
    
}
