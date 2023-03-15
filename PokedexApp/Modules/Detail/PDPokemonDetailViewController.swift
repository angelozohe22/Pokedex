//
//  PDPokemonDetailViewController.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import UIKit
import PDKit

protocol PDPokemonDetailView: AnyObject {
    
}

final class PDPokemonDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    
    
    // MARK: - Lazy properties
    
    lazy var configurator: PDPokemonDetailConfigurator = { return PDPokemonDetailConfigurator(from: self) }()
    lazy var presenter: PDPokemonDetailPresenterProtocol = { return self.configurator.configure() }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Functions
    
    func initView() {
        
    }

}

// MARK: - PDPokemonDetailView

extension PDPokemonDetailViewController: PDPokemonDetailView {
    
    
    
}

// MARK: - StoryboardInstantiable

extension PDPokemonDetailViewController: StoryboardInstantiable {
    
    static var storyboardName: String { "PokemonDetail" }
    
}
