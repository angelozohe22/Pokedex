//
//  PDFonts.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

public enum PDFonts: String, CaseIterable {
    
    case productSansBoldItalic = "ProductSans-BoldItalic"
    case productSansBold = "ProductSans-Bold"
    case productSansItalic = "ProductSans-Italic"
    case productSansRegular = "ProductSans-Regular"
    
    public func withSize(_ fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: self.rawValue, size: fontSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    
}
