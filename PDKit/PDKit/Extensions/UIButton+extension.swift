//
//  UIButton+extension.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 22/03/23.
//

import UIKit

extension UIButton {
    
    /// This function allows you to give a style to the buttons of the application when it is active
    public func setActiveStyle() {
        titleLabel?.font = PDFonts.productSansBold.withSize(14.0)
        backgroundColor = PDColors.cl_Red
        layer.cornerRadius = 4.0
        isUserInteractionEnabled = true
        tintColor = PDColors.cl_White
    }
    
}
