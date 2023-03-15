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
    
}
