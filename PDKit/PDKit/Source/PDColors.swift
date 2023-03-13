//
//  PDColors.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

/*
 * PDColors
 
 These colors are those that are used throughout the pokedex api project.
 
 1) To use them we will have to import the PDKit framework.
 
 - import PDKit
 
 2) Then we will have to make a call to the PDColors class and the name of the color to use.
 
 - Example:
    let colorBlack: UIColor = PDColors.cl_Black
 
 3) Finally we will have to set the value obtained in a View.
 
 - Example:
    self.titleLabel.textColor = colorBlack
 
 */

public struct PDColors {
    
    // MARK: - NAME
    
    struct Name {
        
        static let cl_Black = "cl-black"
        static let cl_White = "cl-white"
        static let cl_LightGray = "cl-light-gray"
        static let cl_AirBlue = "cl-air-blue"
        static let cl_AirBlueLight = "cl-air-blue-light"
        static let cl_Amethyst = "cl-amethyst"
        static let cl_AmethystLight = "cl-amethyst-light"
        static let cl_Blue = "cl-blue"
        static let cl_BlueLight = "cl-blue-light"
        static let cl_CadetGray = "cl-cadet-gray"
        static let cl_CadetGrayLight = "cl-cadet-gray-light"
        static let cl_Cerise = "cl-cerise"
        static let cl_CeriseLight = "cl-cerise-light"
        static let cl_Ecru = "cl-ecru"
        static let cl_EcruLight = "cl-ecru-light"
        static let cl_EnglishViolet = "cl-english-violet"
        static let cl_EnglishVioletLight = "cl-english-violet-light"
        static let cl_Mantis = "cl-mantis"
        static let cl_MantisLight = "cl-mantis-light"
        static let cl_Mustard = "cl-mustard"
        static let cl_MustardLight = "cl-mustard-light"
        static let cl_NationsBlue = "cl-nations-blue"
        static let cl_NationsBlueLight = "cl-nations-blue-light"
        static let cl_Orange = "cl-orange"
        static let cl_OrangeLight = "cl-orange-light"
        static let cl_Pink = "cl-pink"
        static let cl_PinkLight = "cl-pink-light"
        static let cl_Red = "cl-red"
        static let cl_RedLight = "cl-red-light"
        static let cl_Sienna = "cl-sienna"
        static let cl_SiennaLight = "cl-sienna-light"
        static let cl_TiffanyBlue = "cl-tiffany-blue"
        static let cl_TiffanyBlueLight = "cl-tiffany-blue-light"
        static let cl_TrueBlue = "cl-true-blue"
        static let cl_TrueBlueLight = "cl-true-blue-light"
        static let cl_VistaBlue = "cl-vista-blue"
        static let cl_VistaBlueLight = "cl-vista-blue-light"
        static let cl_YellowGreen = "cl-yellow-green"
        static let cl_YellowGreenLight = "cl-yellow-green-light"
        
    }
    
    // MARK: - COLORS
    
    /// This color is used to text or another case
    public static let cl_Black = UIColor.loadColor(named: Name.cl_Black)
    
    /// This color is used to text, background or another case
    public static let cl_White = UIColor.loadColor(named: Name.cl_White)
    
    /// This color is used to background or another case
    public static let cl_LightGray = UIColor.loadColor(named: Name.cl_LightGray)
    
    /// This color is used to highlight the *steel* type pokemon.
    public static let cl_AirBlue = UIColor.loadColor(named: Name.cl_AirBlue)
    
    /// This semi-transparent color is used for the card of a *steel* type pokemon.
    public static let cl_AirBlueLight = UIColor.loadColor(named: Name.cl_AirBlueLight)
    
    /// This color is used to highlight the *poison* type pokemon.
    public static let cl_Amethyst = UIColor.loadColor(named: Name.cl_Amethyst)
    
    /// This semi-transparent color is used for the card of a *poison* type pokemon.
    public static let cl_AmethystLight = UIColor.loadColor(named: Name.cl_AmethystLight)
    
    /// This color is used to highlight the *dragon* type pokemon.
    public static let cl_Blue = UIColor.loadColor(named: Name.cl_Blue)
    
    /// This semi-transparent color is used for the card of a *dragon* type pokemon.
    public static let cl_BlueLight = UIColor.loadColor(named: Name.cl_BlueLight)
    
    /// This color is used to highlight the *normal* type pokemon.
    public static let cl_CadetGray = UIColor.loadColor(named: Name.cl_CadetGray)
    
    /// This semi-transparent color is used for the card of a *normal* type pokemon.
    public static let cl_CadetGrayLight = UIColor.loadColor(named: Name.cl_CadetGrayLight)
    
    /// This color is used to highlight the *fighting* type pokemon.
    public static let cl_Cerise = UIColor.loadColor(named: Name.cl_Cerise)
    
    /// This semi-transparent color is used for the card of a *fighting* type pokemon.
    public static let cl_CeriseLight = UIColor.loadColor(named: Name.cl_CeriseLight)
    
    /// This color is used to highlight the *rock* type pokemon.
    public static let cl_Ecru = UIColor.loadColor(named: Name.cl_Ecru)
    
    /// This semi-transparent color is used for the card of a *rock* type pokemon.
    public static let cl_EcruLight = UIColor.loadColor(named: Name.cl_EcruLight)
    
    /// This color is used to highlight the *dark* type pokemon.
    public static let cl_EnglishViolet = UIColor.loadColor(named: Name.cl_EnglishViolet)
    
    /// This semi-transparent color is used for the card of a *dark* type pokemon.
    public static let cl_EnglishVioletLight = UIColor.loadColor(named: Name.cl_EnglishVioletLight)
    
    /// This color is used to highlight the *grass* type pokemon.
    public static let cl_Mantis = UIColor.loadColor(named: Name.cl_Mantis)
    
    /// This semi-transparent color is used for the card of a *grass* type pokemon.
    public static let cl_MantisLight = UIColor.loadColor(named: Name.cl_MantisLight)
    
    /// This color is used to highlight the *electric* type pokemon.
    public static let cl_Mustard = UIColor.loadColor(named: Name.cl_Mustard)
    
    /// This semi-transparent color is used for the card of a *electric* type pokemon.
    public static let cl_MustardLight = UIColor.loadColor(named: Name.cl_MustardLight)
    
    /// This color is used to highlight the *water* type pokemon.
    public static let cl_NationsBlue = UIColor.loadColor(named: Name.cl_NationsBlue)
    
    /// This semi-transparent color is used for the card of a *water* type pokemon.
    public static let cl_NationsBlueLight = UIColor.loadColor(named: Name.cl_NationsBlueLight)
    
    /// This color is used to highlight the *fire* type pokemon.
    public static let cl_Orange = UIColor.loadColor(named: Name.cl_Orange)
    
    /// This semi-transparent color is used for the card of a *fire* type pokemon.
    public static let cl_OrangeLight = UIColor.loadColor(named: Name.cl_OrangeLight)
    
    /// This color is used to highlight the *fairy* type pokemon.
    public static let cl_Pink = UIColor.loadColor(named: Name.cl_Pink)
    
    /// This semi-transparent color is used for the card of a *fairy* type pokemon.
    public static let cl_PinkLight = UIColor.loadColor(named: Name.cl_PinkLight)
    
    /// This color is used to highlight the *psychic* type pokemon.
    public static let cl_Red = UIColor.loadColor(named: Name.cl_Red)
    
    /// This semi-transparent color is used for the card of a *psychic* type pokemon.
    public static let cl_RedLight = UIColor.loadColor(named: Name.cl_RedLight)
    
    /// This color is used to highlight the *ground* type pokemon.
    public static let cl_Sienna = UIColor.loadColor(named: Name.cl_Sienna)
    
    /// This semi-transparent color is used for the card of a *ground* type pokemon.
    public static let cl_SiennaLight = UIColor.loadColor(named: Name.cl_SiennaLight)
    
    /// This color is used to highlight the *ice* type pokemon.
    public static let cl_TiffanyBlue = UIColor.loadColor(named: Name.cl_TiffanyBlue)
    
    /// This semi-transparent color is used for the card of a *ice* type pokemon.
    public static let cl_TiffanyBlueLight = UIColor.loadColor(named: Name.cl_TiffanyBlueLight)
    
    /// This color is used to highlight the *ghost* type pokemon.
    public static let cl_TrueBlue = UIColor.loadColor(named: Name.cl_TrueBlue)
    
    /// This semi-transparent color is used for the card of a *ghost* type pokemon.
    public static let cl_TrueBlueLight = UIColor.loadColor(named: Name.cl_TrueBlueLight)
    
    /// This color is used to highlight the *flying* type pokemon.
    public static let cl_VistaBlue = UIColor.loadColor(named: Name.cl_VistaBlue)
    
    /// This semi-transparent color is used for the card of a *flying* type pokemon.
    public static let cl_VistaBlueLight = UIColor.loadColor(named: Name.cl_VistaBlueLight)
    
    /// This color is used to highlight the *bug* type pokemon.
    public static let cl_YellowGreen = UIColor.loadColor(named: Name.cl_YellowGreen)
    
    /// This semi-transparent color is used for the card of a *bug* type pokemon.
    public static let cl_YellowGreenLight = UIColor.loadColor(named: Name.cl_YellowGreenLight)
    
    
}
