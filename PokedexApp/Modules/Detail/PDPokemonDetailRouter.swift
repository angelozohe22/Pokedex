//
//  PDPokemonDetailRouter.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import UIKit

protocol PDPokemonDetailRouterProtocol {
    
    func routeToParent()
    
}

final class PDPokemonDetailRouter {

    // MARK: - Properties
    
    private var viewController: UIViewController
    
    // MARK: - Lifecycle
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

}

// MARK: - PDPokemonDetailRouterProtocol

extension PDPokemonDetailRouter: PDPokemonDetailRouterProtocol {
    
    func routeToParent() {
        self.viewController.navigationController?.popViewController(animated: true)
    }
    
}
