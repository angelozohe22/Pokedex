//
//  PDImage.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

/**
 * PDImage
 
 These images are those that are used throughout the pokedex api project.
 
 1) To use them we will have to import the PDKit framework.
 
 - import PDKit
 
 2) Then we will have to make a call to the PDImage class and the name of the image to use.
 
 - Example:
    let imagePokeball: UIImage = PDImage.imgPokeballClear
 
 3) Finally we will have to set the value obtained in a UIImageView.
 
 - Example:
    self.pokeballImageView.image = imagePokeball
 
 */

public struct PDImage {
    
    // MARK: - Name
    
    struct Name {
        
        static let imgPokeballClear = "img-pokeball-clear"
        static let imgPokeballEmpty = "img-pokeball-empty"
        static let imgPokeball = "img-pokeball"
        static let imgPokemonTitle = "img-pokemon-title"
        static let imgDisconnect = "img-disconnect"
        
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
    
    /// This image is used to display that application has no internet connection
    public static let imgDisconnect = UIImage.loadImage(named: Name.imgDisconnect)
    
}
