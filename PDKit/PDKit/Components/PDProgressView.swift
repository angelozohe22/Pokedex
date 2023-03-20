//
//  PDProgressView.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import UIKit

public class PDProgressView {
    
    private init() {}
    
    public static let shared = PDProgressView()
    
    var containerView = UIView()
    var containerIndicator = UIView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    public var containerSize: CGFloat = 80
    public var indicatorSize: CGFloat = 40
    public var containerColor = PDColors.cl_White
    public var backgroundColor = PDColors.cl_BlackOpaque
    public var indicatorColor = UIColor.gray
    
    public func showProgressView(in parentView: UIView) {
        // Container
        containerView.frame = parentView.bounds
        containerView.backgroundColor = backgroundColor
        containerView.addSubview(containerIndicator)
        // Container indicator
        containerIndicator.frame = CGRect(x: 0, y: 0, width: containerSize, height: containerSize)
        containerIndicator.center = containerView.center
        containerIndicator.backgroundColor = containerColor
        containerIndicator.clipsToBounds = true
        containerIndicator.layer.cornerRadius = 10
        containerIndicator.addSubview(activityIndicator)
        // Indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.frame = CGRect(x: 0, y: 0, width: indicatorSize, height: indicatorSize)
        activityIndicator.color = indicatorColor
        activityIndicator.centerXAnchor.constraint(equalTo: containerIndicator.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: containerIndicator.centerYAnchor).isActive = true
        parentView.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    public func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
}
