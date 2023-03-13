//
//  UIView+constraints.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

public extension UIView {
    
    func pinToSuperview(with insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            fatalError("No superview found")
        }
        NSLayoutConstraint.activate(
            [
                topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left),
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
            ]
        )
    }
    
    func pinToSafeAreaSuperview(with insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            fatalError("No superview found")
        }
        NSLayoutConstraint.activate(
            [
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: insets.top),
                leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: insets.left),
                rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: -insets.right),
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom)
            ]
        )
    }
    
    func centerInParent() {
        guard let superview = superview else {
            fatalError("No superview found")
        }
        NSLayoutConstraint.activate(
            [
                centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ]
        )
    }
    
    func centerVertically(with horizontalPadding: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("No superview found")
        }
        NSLayoutConstraint.activate(
            [
                centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: horizontalPadding),
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -horizontalPadding),
            ]
        )
    }
    
    func centerHorizontally(with vertialPadding: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("No superview found")
        }
        NSLayoutConstraint.activate(
            [
                centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                topAnchor.constraint(equalTo: superview.topAnchor, constant: vertialPadding),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -vertialPadding),
            ]
        )
    }
    
    func setSquareForm(with size: CGFloat) {
        NSLayoutConstraint.activate(
            [
                widthAnchor.constraint(equalToConstant: size),
                heightAnchor.constraint(equalTo: widthAnchor)
            ]
        )
    }
    
}
