//
//  PDImage.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

public struct PDImage {
    
    // MARK: - Name
    
    struct Name {
        
        static let imgPokeballClear = "img-pokeball-clear"
        static let imgPokeballEmpty = "img-pokeball-empty"
        static let imgPokeball = "img-pokeball"
        static let imgPokemonTitle = "img-pokemon-title"
        
    }
    
    // MARK: - Images
    
    ///This image is used to handle transparently and change its color
    public static let imgPokeballClear = UIImage.loadImage(named: Name.imgPokeballClear)
    
    /// This image is used to show an empty space as in a search
    public static let imgPokeballEmpty = UIImage.loadImage(named: Name.imgPokeballEmpty)
    
    /// This image is used in any occasion
    public static let imgPokeball = UIImage.loadImage(named: Name.imgPokeball)
    
    /// This image is used to display the title of the application
    public static let imgPokemonTitle = UIImage.loadImage(named: Name.imgPokemonTitle)
    
}
