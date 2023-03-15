//
//  Bundle+extension.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import Foundation

public class PDBundle {}

extension Bundle {
    
    static func generatePDBundle() -> Bundle {
        Bundle(for: PDBundle.self)
    }
    
}
