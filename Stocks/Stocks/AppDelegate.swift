//
//  AppDelegate.swift
//  Stocks
//
//  Created by Дина Турман on 24.05.2022.
//

import UIKit

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ModuleBuilder.shared.tabbarController()
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}


