//
//  PokemonDtoMapper.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

class PokemonDtoMapper {
    
    class func mapPokemonToPokemonDto(pokemon: Pokemon) -> PokemonDto {
        return PokemonDto(id: pokemon.id ?? 0,
                          name: pokemon.name,
                          url: pokemon.url,
                          imageUrl: pokemon.imageUrl ?? "",
                          detail: mapPokemonDetailToPokemonDetailDto(pokemonDetail: pokemon.detail))
    }
    
    class func mapPokemonDtoToPokemon(pokemonDto: PokemonDto) -> Pokemon {
        return Pokemon(name: pokemonDto.name,
                       url: pokemonDto.url,
                       detail: mapPokemonDetailDtoToPokemonDetail(pokemonDetailDto: pokemonDto.detail))
    }
    
    class func mapPokemonDetailToPokemonDetailDto(pokemonDetail: PokemonDetail?) -> PokemonDetailDto? {
        guard let pokemonDetail = pokemonDetail else { return nil }
        return PokemonDetailDto(height: pokemonDetail.height,
                                weight: pokemonDetail.weight,
                                abilities: mapAbilitiesToAbilitiesDto(abilities: pokemonDetail.abilities),
                                stats: mapStatsToStatsDto(stats: pokemonDetail.stats),
                                types: mapTypesToTypesDto(types: pokemonDetail.types))
    }
    
    class func mapPokemonDetailDtoToPokemonDetail(pokemonDetailDto: PokemonDetailDto?) -> PokemonDetail? {
        guard let pokemonDetailDto = pokemonDetailDto else { return nil }
        return PokemonDetail(height: pokemonDetailDto.height,
                             weight: pokemonDetailDto.weight,
                             abilities: mapAbilitiesDtoToAbilities(abilitiesDto: pokemonDetailDto.abilities),
                             stats: mapStatsDtoToStats(statsDto: pokemonDetailDto.stats),
                             types: mapTypesDtoToTypes(typesDto: pokemonDetailDto.types))
    }
    
    class func mapAbilitiesToAbilitiesDto(abilities: [PokemonDetailAbility]?) -> [PokemonDetailAbilityDto]? {
        guard let abilities = abilities else { return nil }
        return abilities.map { ability in
            PokemonDetailAbilityDto(name: ability.name)
        }
    }
    
    class func mapAbilitiesDtoToAbilities(abilitiesDto: [PokemonDetailAbilityDto]?) -> [PokemonDetailAbility]? {
        guard let abilitiesDto = abilitiesDto else { return nil }
        return abilitiesDto.map { ability in
            PokemonDetailAbility(ability: ability)
        }
    }
    
    class func mapStatsToStatsDto(stats: [PokemonDetailStat]?) -> [PokemonDetailStatDto]? {
        guard let stats = stats else { return nil }
        return stats.map { stat in
            PokemonDetailStatDto(baseStat: stat.baseStat,
                                 effort: stat.effort,
                                 statName: stat.statName)
        }
    }
    
    class func mapStatsDtoToStats(statsDto: [PokemonDetailStatDto]?) -> [PokemonDetailStat]? {
        guard let statsDto = statsDto else { return nil }
        return statsDto.map { stat in
            PokemonDetailStat(stat: stat)
        }
    }
    
    class func mapTypesToTypesDto(types: [PokemonDetailType]?) -> [PokemonDetailTypeDto]? {
        guard let types = types else { return nil }
        return types.map { type in
            PokemonDetailTypeDto(name: type.name)
        }
    }
    
    class func mapTypesDtoToTypes(typesDto: [PokemonDetailTypeDto]?) -> [PokemonDetailType]? {
        guard let typesDto = typesDto else { return nil }
        return typesDto.map { type in
            PokemonDetailType(type: type)
        }
    }
    
}
