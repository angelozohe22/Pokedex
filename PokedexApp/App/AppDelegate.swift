//
//  AppDelegate.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 12/03/23.
//

import UIKit
import PDKit
import PDNetworking
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Register fonts
        UIFont.loadPDCustomFonts()
        
        // Network reachability
        PDNetworkReachability.shared.startMonitoring()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Stop network reachability
        PDNetworkReachability.shared.stopMonitoring()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokedexApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

