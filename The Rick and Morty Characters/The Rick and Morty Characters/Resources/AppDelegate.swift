//
//  AppDelegate.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 16-07-21.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            let window = UIWindow(frame: UIScreen.main.bounds)
            
            if error != nil || user == nil {
                window.rootViewController = GeneralRoute.login.module!
                window.makeKeyAndVisible()
                self?.window = window
            } else {
                let navVC = UINavigationController(rootViewController: GeneralRoute.characterList.module!)
                navVC.navigationBar.prefersLargeTitles = true
                navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
                
                window.rootViewController = navVC
                window.makeKeyAndVisible()
                self?.window = window
            }
        }
        
        return true
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    // MARK: UISceneSession Lifecycle

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


}
