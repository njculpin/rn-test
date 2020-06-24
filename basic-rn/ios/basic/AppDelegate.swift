//
//  AppDelegate.swift
//  basic
//
//  Created by Nick Culpin on 6/22/20.
//  Copyright © 2020 basic. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCTBridgeDelegate {
    func sourceURL(for bridge: RCTBridge!) -> URL! {
        #if DEBUG
            return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource:nil)
        #else
            return Bundle.main.url(forResource:"main", withExtension:"jsbundle")
        #endif
}
    
    var window: UIWindow?
    var bridge: RCTBridge!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.bridge = RCTBridge(delegate: self, launchOptions: launchOptions)

        let rootView = RCTRootView(bridge: self.bridge, moduleName: "basic", initialProperties: nil)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = UIViewController()

        rootViewController.view = rootView

        self.window!.rootViewController = rootViewController;
        self.window!.makeKeyAndVisible()
        
        /*
         ORIGINAL SWIFT ONLY ROOT
        // draw the window to the bounds of the device
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // our home view controller will be first to display
        let home = HomeViewController()
        // provide a navigation controller for the home view controller to live in
        let navigation = UINavigationController(rootViewController: home)
        // render it
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
         */
        
        return true
    }

    // Default boiler plate
    // we are not using scene delegate / swift ui in this project
    // we are not using core data in this project
    // core data could be used for caching the data
    
    // MARK: UISceneSession Lifecycle

    /*
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "basic")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
     */

}

