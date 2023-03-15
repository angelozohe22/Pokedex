//
//  PokemonResponseMapper.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import PDNetworking

class PokemonResponseMapper {
    
    class func mapPokemonResponseToPokemon(response: PokemonResponse) -> Pokemon {
        return Pokemon(name: response.name,
                       url: response.url)
    }
    
    class func mapPokemonDetailResponseToPokemonDetail(response: PokemonDetailResponse) -> PokemonDetail {
        return PokemonDetail(height: response.height,
                             weight: response.weight,
                             abilities: mapAbilitiesResponseToAbilities(response: response.abilities),
                             stats: mapStatsResponseToStats(response: response.stats),
                             types: mapTypesResponseToTypes(response: response.types))
    }
    
    class func mapAbilitiesResponseToAbilities(response: [PokemonAbilityResponse]) -> [PokemonDetailAbility] {
        return response.map { ability in
            PokemonDetailAbility(ability: ability.ability)
        }
    }
    
    class func mapStatsResponseToStats(response: [PokemonStatResponse]) -> [PokemonDetailStat] {
        return response.map { stat in
            PokemonDetailStat(stat: stat)
        }
    }
    
    class func mapTypesResponseToTypes(response: [PokemonTypeResponse]) -> [PokemonDetailType] {
        return response.map { type in
            PokemonDetailType(type: type.type)
        }
    }
    
    class func mapHabitatResponseToHabitat(response: PokemonHabitatResponse) -> PokemonHabitat {
        return PokemonHabitat(id: response.id,
                              name: response.name)
    }
    
    class func mapEvolutionResponseToEvolution(response: PokemonEvolutionResponse) -> PokemonEvolution {
        return PokemonEvolution(chain: mapChainResponseToChain(response: response.chain))
    }
    
    class func mapChainResponseToChain(response: PokemonEvolvesResponse) -> PokemonEvolves {
        return PokemonEvolves(specie: mapSpecieResponseToSpecie(response: response.species),
                              evolvesTo: mapEvolvesResponseToEvolves(evolves: response.evolvesTo))
    }
    
    class func mapEvolvesResponseToEvolves(evolves: [PokemonEvolvesResponse]) -> [PokemonEvolves] {
        return evolves.map { evolution in
            PokemonEvolves(specie: mapSpecieResponseToSpecie(response: evolution.species),
                           evolvesTo: mapEvolvesResponseToEvolves(evolves: evolution.evolvesTo))
        }
    }
    
    class func mapSpecieResponseToSpecie(response: PokemonSpecieResponse) -> PokemonSpecie {
        return PokemonSpecie(name: response.name)
    }
    
    class func mapDescriptionResponseToDescription(response: [PokemonDescriptionDetailResponse]) -> [PokemonDescription] {
        return response.map { description in
            PokemonDescription(description: description.description)
        }
    }
    
}
