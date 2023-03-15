//
//  Data+extension.swift
//  PDNetworking
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import Foundation

extension Data {
    
    func parseData(removeString string: String) -> Data? {
        let stringData = String(data:self, encoding: .utf8)
        let dataStringParsed  = stringData?.replacingOccurrences(of: string, with: "")
        guard let data = dataStringParsed?.data(using: .utf8) else { return nil }
        return data
    }
    
}
