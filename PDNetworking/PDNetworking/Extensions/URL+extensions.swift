//
//  URL+extensions.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

extension URL {

    init?<Request: BaseRequest>(request: Request) {
        let allowedChars = CharacterSet.urlPathAllowed.union(.urlQueryAllowed)
        guard let encodedService = request.service.addingPercentEncoding(withAllowedCharacters: allowedChars) else {
            return nil
        }
        guard let encodedPath = request.path.addingPercentEncoding(withAllowedCharacters: allowedChars) else {
            return nil
        }
        let raw = request.baseURL + encodedService + encodedPath
        guard let url = URL(string: raw) else {
            return nil
        }
        self = url
    }

}
