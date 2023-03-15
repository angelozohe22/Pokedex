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
    var activityIndicator = UIActivityIndicatorView()
    
    public func showProgressView() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        // Container
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = PDColors.cl_BlackOpaque
        containerView.addSubview(containerIndicator)
        // Container indicator
        containerIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        containerIndicator.center = window.center
        containerIndicator.backgroundColor = PDColors.cl_White
        containerIndicator.clipsToBounds = true
        containerIndicator.layer.cornerRadius = 10
        containerIndicator.addSubview(activityIndicator)
        // Indicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .large
        activityIndicator.color = UIColor.gray
        activityIndicator.center = CGPoint(x: containerIndicator.bounds.width / 2, y: containerIndicator.bounds.height / 2)
        UIApplication.shared.keyWindow?.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    public func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
}
