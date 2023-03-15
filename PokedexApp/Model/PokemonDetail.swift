//
//  PokemonDetail.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation
import PDNetworking
import PDKit
import UIKit

struct PokemonDetail {
    
    let height: Int
    let weight: Int
    let abilities: [PokemonDetailAbility]?
    let stats: [PokemonDetailStat]?
    let types: [PokemonDetailType]?
    
}

struct PokemonDetailAbility {
    
    let name: String
    
    init(ability: PokemonAbility) {
        self.name = ability.name
    }
    
    init(ability: PokemonDetailAbilityDto) {
        self.name = ability.name
    }
    
}

struct PokemonDetailStat {
    
    let baseStat: Int
    let effort: Int
    let statName: String
    
    init(stat: PokemonStatResponse) {
        self.baseStat = stat.baseStat
        self.effort = stat.effort
        self.statName = stat.stat.name
    }
    
    init(stat: PokemonDetailStatDto) {
        self.baseStat = stat.baseStat
        self.effort = stat.effort
        self.statName = stat.statName
    }
    
}

struct PokemonDetailType {
    
    let name: String
    
    init(type: PokemonType) {
        self.name = type.name
    }
    
    init(type: PokemonDetailTypeDto) {
        self.name = type.name
    }
    
    var typeBackgroundColor: UIColor {
        switch name.lowercased() {
        case "grass": return PDColors.cl_MantisLight
        case "poison": return PDColors.cl_AmethystLight
        case "steel": return PDColors.cl_AirBlueLight
        case "dragon": return PDColors.cl_BlueLight
        case "normal": return PDColors.cl_CadetGrayLight
        case "fighting": return PDColors.cl_CeriseLight
        case "rock": return PDColors.cl_EcruLight
        case "dark": return PDColors.cl_EnglishVioletLight
        case "electric": return PDColors.cl_MustardLight
        case "water": return PDColors.cl_NationsBlueLight
        case "fire": return PDColors.cl_OrangeLight
        case "fairy": return PDColors.cl_PinkLight
        case "psychic": return PDColors.cl_RedLight
        case "ground": return PDColors.cl_SiennaLight
        case "ice": return PDColors.cl_TiffanyBlueLight
        case "ghost": return PDColors.cl_TrueBlueLight
        case "flying": return PDColors.cl_VistaBlueLight
        case "bug": return PDColors.cl_YellowGreenLight
        default: return PDColors.cl_CadetGrayLight
        }
    }
    
    var typeColor: UIColor {
        switch name.lowercased() {
        case "grass": return PDColors.cl_Mantis
        case "poison": return PDColors.cl_Amethyst
        case "steel": return PDColors.cl_AirBlue
        case "dragon": return PDColors.cl_Blue
        case "normal": return PDColors.cl_CadetGray
        case "fighting": return PDColors.cl_Cerise
        case "rock": return PDColors.cl_Ecru
        case "dark": return PDColors.cl_EnglishViolet
        case "electric": return PDColors.cl_Mustard
        case "water": return PDColors.cl_NationsBlue
        case "fire": return PDColors.cl_Orange
        case "fairy": return PDColors.cl_Pink
        case "psychic": return PDColors.cl_Red
        case "ground": return PDColors.cl_Sienna
        case "ice": return PDColors.cl_TiffanyBlue
        case "ghost": return PDColors.cl_TrueBlue
        case "flying": return PDColors.cl_VistaBlue
        case "bug": return PDColors.cl_YellowGreen
        default: return PDColors.cl_CadetGray
        }
    }
    
    var typeIcon: UIImage {
        switch name.lowercased() {
        case "grass": return PDIcon.icTypeGrass
        case "poison": return PDIcon.icTypePoison
        case "steel": return PDIcon.icTypeSteel
        case "dragon": return PDIcon.icTypeDragon
        case "normal": return PDIcon.icTypeNormal
        case "fighting": return PDIcon.icTypeFighting
        case "rock": return PDIcon.icTypeRock
        case "dark": return PDIcon.icTypeDark
        case "electric": return PDIcon.icTypeElectric
        case "water": return PDIcon.icTypeWater
        case "fire": return PDIcon.icTypeFire
        case "fairy": return PDIcon.icTypeFairy
        case "psychic": return PDIcon.icTypePsychic
        case "ground": return PDIcon.icTypeGround
        case "ice": return PDIcon.icTypeIce
        case "ghost": return PDIcon.icTypeGhost
        case "flying": return PDIcon.icTypeFlying
        case "bug": return PDIcon.icTypeBug
        default: return PDIcon.icTypeNormal
        }
    }
    
}
