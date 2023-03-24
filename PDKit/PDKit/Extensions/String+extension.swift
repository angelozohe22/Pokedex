//
//  String+extension.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import Foundation

public extension String {
    
    func firstCapitalize() -> String {
        self.prefix(1).capitalized + dropFirst()
    }
    
    func capitalizeAfterDot() -> String {
        var shouldCapitalizeNextChar = true
        let result = self.lowercased().map { currentCharacter -> String in
            if currentCharacter == "." {
                shouldCapitalizeNextChar = true
                return String(currentCharacter)
            }
            if shouldCapitalizeNextChar && currentCharacter.isLetter {
                shouldCapitalizeNextChar = false
                return String(currentCharacter.uppercased())
            }
            return String(currentCharacter)
        }.joined()
        return result
    }
    
    func removeAllNewLines() -> String {
        self.replacingOccurrences(of: "\u{C}", with: " ")
            .replacingOccurrences(of: "\n", with: " ")
    }
    
}
