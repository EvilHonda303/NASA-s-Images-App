//
//  AppDelegate.swift
//  NASA's Image&Video Library
//
//  Created by macintosh on 02/03/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = ImageController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

