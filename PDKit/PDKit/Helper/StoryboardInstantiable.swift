//
//  StoryboardInstantiable.swift
//  PDKit
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit

public protocol StoryboardInstantiable {
    
    static var storyboardId: String { get }
    static var storyboardName: String { get }
    
}

public extension StoryboardInstantiable where Self: UIViewController {
    
    static var storyboardInstance: Self {
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId) as? Self else { fatalError("Unable to load \(storyboardId) from storyboard")  }
        return viewController
    }
    
    static var storyboardId: String {
        return NSStringFromClass(self).components(separatedBy:(".")).last ?? ""
    }
    
}
