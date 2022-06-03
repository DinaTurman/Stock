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
    
    let favoritesService: FavoritesServiceProtocol = FavoritesLocalService()
    
    private lazy var stocksService: StocksServiceProtocol = StocksService(client: network)


    
    
    func stocksModule() -> UIViewController {
        let presenter = StocksPresenter(service: stocksService)
        let view = StocksViewController(presenter: presenter)
        presenter.view = view
        
        
        return view
    }
    
    func detailVC(for model: StockModelProtocol) -> UIViewController {
        let presenter = DetailStockPresenter(model: model, service: stocksService)
        let view = DetailViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func favoriteVC() -> UIViewController {
        let presenter = FavoritePresenter()
        let view = FavoriteViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let stocksVC = UINavigationController(rootViewController: stocksModule())
        stocksVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "diagram"), tag: 0)
        
        let secondVC = UINavigationController(rootViewController: favoriteVC())
        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Star"), tag: 1)
        
        
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

