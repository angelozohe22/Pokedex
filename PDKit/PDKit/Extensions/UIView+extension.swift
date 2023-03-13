//
//  UIView+extension.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

public extension UIView {
    
    func addRadius(cornerRadius: CGFloat = 8.0) {
        layer.cornerRadius = cornerRadius
    }
    
    func addBorder(with color: UIColor, width: CGFloat = 1, cornerRadius: CGFloat = 8.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
    }
    
    func addShadow(radius: CGFloat = 8.0, opacity: Float = 1) {
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = PDColors.cl_Shadow.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    @discardableResult
    func withSubviews(_ views: UIView...) -> UIView {
        views.forEach { addSubview($0) }
        return self
    }
    
}
