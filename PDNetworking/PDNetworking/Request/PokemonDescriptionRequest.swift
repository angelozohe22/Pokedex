//
//  PokemonDescriptionRequest.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

public struct PokemonDescriptionRequest: GetRequest {
    
    // MARK: - Alias
    
    public typealias Response = [PokemonDescriptionDetailResponse]
    
    // MARK: - Properties
    
    public var body: PDEmptyRequest = PDEmptyRequest()
    
    public var baseURL: String { PDEnvironment.Environment.prod.firebaseBaseUrl }
    
    public var service: String { PDServiceType.pokemon.rawValue }
    
    public var path: String { ".json" }
    
    public var headers: [HeaderKey : String] { PDHeaders.getHeaders() }
    
    // MARK: - Lifecycle
    
    public init() {}
    
}

extension PokemonDescriptionRequest {
    
    public func decode(_ data: Data) throws -> [PokemonDescriptionDetailResponse] {
        let dataFormatted = data.parseData(removeString: "null,") ?? Data()
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: dataFormatted)
    }
    
}

public struct PokemonDescriptionDetailResponse: Decodable {
    
    public let description : String
    
}

