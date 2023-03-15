//
//  PDFonts.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

/**
 * PDFonts
 
 These fonts are those that are used throughout the pokedex api project.
 
 1) To use them we will have to import the PDKit framework.
 
 - import PDKit
 
 2) Then we will have to make a call to the PDFonts class and the name of the font to use,
 in addition to using the withSize function that allows us to set a size for the text to be displayed.
 
 - Example:
   self.pokemonName.font = PDFonts.productSansRegular.withSize(16.0)
 
 */

public enum PDFonts: String, CaseIterable {
    
    case productSansBoldItalic = "ProductSans-BoldItalic"
    case productSansBold = "ProductSans-Bold"
    case productSansItalic = "ProductSans-Italic"
    case productSansRegular = "ProductSans-Regular"
    
    /*
     * fontSize is the size that the text will take.
     */
    public func withSize(_ fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: self.rawValue, size: fontSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    
}
