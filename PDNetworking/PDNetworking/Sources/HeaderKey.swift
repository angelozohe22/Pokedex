//
//  HeaderKey.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

public enum HeaderKey: String {
    
    case contentType = "Content-Type"
    
}


public class PDHeaders {
    
    public static func getHeaders() -> [HeaderKey: String] {
        var headers: [HeaderKey: String] = [
            .contentType: "application/json"
        ]
        
        return headers
    }
    
}


