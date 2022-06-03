//
//  ModuleBuilder.swift
//  Stocks
//
//  Created by Дина Турман on 29.05.2022.
//

import Foundation
import UIKit

final class ModuleBuilder {
    private init() {}
    
    private lazy var network: NetworkService = {
        Network()
    }()
    
    static let shared: ModuleBuilder = .init()
    
    func networkService() -> NetworkService {
        network
    }
    
    func stocksService() -> StocksServiceProtocol {
        StocksService(client: network)
    }
    
    func stocksModule() -> UIViewController {
        let presenter = StocksPresenter(service: stocksService())
        let view = StocksViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func detailVC() -> UIViewController {
        let presenter = DetailPresenter(service: stocksService())
        let view = DetailViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func searchVC() -> UIViewController {
        UIViewController()
    }
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let stocksVC = UINavigationController(rootViewController: stocksModule())
        stocksVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "diagram"), tag: 0)
        
        let secondVC = searchVC()
        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Star"), tag: 2)
        
        let thirdVC = thirdVC()
        thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), tag: 2)
        
        tabbar.viewControllers = [stocksVC, secondVC, thirdVC]
        
        setupNavBar()
        
        return tabbar
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

