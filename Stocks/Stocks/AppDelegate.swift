//
//  AppDelegate.swift
//  Stocks
//
//  Created by Дина Турман on 24.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let stocksVC = StocksViewController()
        
        let navController = UINavigationController(rootViewController: stocksVC)
        setupNavBar()
        let tabBarController = UITabBarController()
        navController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "diagram"), tag: 0)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        
        tabBarController.viewControllers = [navController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
       
        return true
    }
}

extension AppDelegate {
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
