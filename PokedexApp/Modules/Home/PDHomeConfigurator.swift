//
//  PDHomeConfigurator.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

final class PDHomeConfigurator {
    
    // MARK: - Properties
    
    private var viewController: PDHomeViewController
    
    // MARK: - Lifecycle
    
    init(from viewController: PDHomeViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    
    func configure() -> PDHomePresenter {
        let router = PDHomeRouter(viewController: self.viewController)
        let localRepository = PDHomeLocalRepository()
        let remoteRepository = PDHomeRemoteRepository()
        let interactor = PDHomeInteractor(localRepository: localRepository,
                                          remoteRepository: remoteRepository)
        let presenter = PDHomePresenter(view: self.viewController,
                                        interactor: interactor,
                                        router: router)
        return presenter
    }
    
}
