//
//  UIImage+extension.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

extension UIImage {
    
    static func loadImage(named name: String) -> UIImage {
        guard let image = UIImage(named: name, in: .generatePDBundle(), compatibleWith: nil) else { fatalError("Image \(name) not found") }
        return image
    }
    
}
