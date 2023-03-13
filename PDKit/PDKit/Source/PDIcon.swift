//
//  PDIcon.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

/*
 * PDIcon
 
 These icons are those that are used throughout the pokedex api project.
 
 1) To use them we will have to import the PDKit framework.
 
 - import PDKit
 
 2) Then we will have to make a call to the PDIcon class and the name of the icon to use.
 
 - Example:
    let icType: UIImage = PDImage.icTypeDark
 
 3) Finally we will have to set the value obtained in a UIImageView.
 
 - Example:
    self.pokemonTypeImageView.image = icType
 
 */

public struct PDIcon {
    
    // MARK: - Name
    
    struct Name {
        
        static let icTypeBug = "ic-type-bug"
        static let icTypeDark = "ic-type-dark"
        static let icTypeDragon = "ic-type-dragon"
        static let icTypeElectric = "ic-type-electric"
        static let icTypeFairy = "ic-type-fairy"
        static let icTypeFighting = "ic-type-fighting"
        static let icTypeFire = "ic-type-fire"
        static let icTypeFlying = "ic-type-flying"
        static let icTypeGhost = "ic-type-ghost"
        static let icTypeGrass = "ic-type-grass"
        static let icTypeGround = "ic-type-ground"
        static let icTypeIce = "ic-type-ice"
        static let icTypeNormal = "ic-type-normal"
        static let icTypePoison = "ic-type-poison"
        static let icTypePsychic = "ic-type-psychic"
        static let icTypeRock = "ic-type-rock"
        static let icTypeSteel = "ic-type-steel"
        static let icTypeWater = "ic-type-water"
        
    }
    
    // MARK: - Icons
    
    /// This icon is used to indicate that the pokemon is a bug type.
    public static let icTypeBug =  UIImage.loadImage(named: Name.icTypeBug)
    
    /// This icon is used to indicate that the pokemon is a dark type.
    public static let icTypeDark =  UIImage.loadImage(named: Name.icTypeDark)
    
    /// This icon is used to indicate that the pokemon is a dragon type.
    public static let icTypeDragon =  UIImage.loadImage(named: Name.icTypeDragon)
    
    /// This icon is used to indicate that the pokemon is a electric type.
    public static let icTypeElectric =  UIImage.loadImage(named: Name.icTypeElectric)
    
    /// This icon is used to indicate that the pokemon is a fairy type.
    public static let icTypeFairy =  UIImage.loadImage(named: Name.icTypeFairy)
    
    /// This icon is used to indicate that the pokemon is a fighting type.
    public static let icTypeFighting =  UIImage.loadImage(named: Name.icTypeFighting)
    
    /// This icon is used to indicate that the pokemon is a fire type.
    public static let icTypeFire =  UIImage.loadImage(named: Name.icTypeFire)
    
    /// This icon is used to indicate that the pokemon is a flying type.
    public static let icTypeFlying =  UIImage.loadImage(named: Name.icTypeFlying)
    
    /// This icon is used to indicate that the pokemon is a ghost type.
    public static let icTypeGhost =  UIImage.loadImage(named: Name.icTypeGhost)
    
    /// This icon is used to indicate that the pokemon is a grass type.
    public static let icTypeGrass =  UIImage.loadImage(named: Name.icTypeGrass)
    
    /// This icon is used to indicate that the pokemon is a ground type.
    public static let icTypeGround =  UIImage.loadImage(named: Name.icTypeGround)
    
    /// This icon is used to indicate that the pokemon is a ice type.
    public static let icTypeIce =  UIImage.loadImage(named: Name.icTypeIce)
    
    /// This icon is used to indicate that the pokemon is a normal type.
    public static let icTypeNormal =  UIImage.loadImage(named: Name.icTypeNormal)
    
    /// This icon is used to indicate that the pokemon is a poison type.
    public static let icTypePoison =  UIImage.loadImage(named: Name.icTypePoison)
    
    /// This icon is used to indicate that the pokemon is a psychic type.
    public static let icTypePsychic =  UIImage.loadImage(named: Name.icTypePsychic)
    
    /// This icon is used to indicate that the pokemon is a rock type.
    public static let icTypeRock =  UIImage.loadImage(named: Name.icTypeRock)
    
    /// This icon is used to indicate that the pokemon is a steel type.
    public static let icTypeSteel =  UIImage.loadImage(named: Name.icTypeSteel)
    
    /// This icon is used to indicate that the pokemon is a water type.
    public static let icTypeWater =  UIImage.loadImage(named: Name.icTypeWater)
    
}
