//
//  NetworkingError.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

public enum NetworkingError: Error {
    
    case notConnectionInternet
    case invalidRequestError(String)
    case unexpectedError(Error)
    case invalidResponse
    case unauthorized
    case noContent
    case parsingError(Error, String)
    
}
