//
//  StockModel.swift
//  Stocks
//
//  Created by Дина Турман on 29.05.2022.
//

import Foundation
import UIKit

protocol StockModelProtocol {
    var id: String { get }
    var name: String { get }
    var iconURL: String { get }
    var symbol: String { get }
    var price: String { get }
    var change: String { get }
    var changeColor: UIColor { get }
    
    var isFavorite: Bool { get set }
    
    func setFavorite()
}

final class StockModel: StockModelProtocol {
    private let stock: Stock
    let favoriteService: FavoritesServiceProtocol

    init(stock: Stock) {
        self.stock = stock
        favoriteService = ModuleBuilder.shared.favoritesService
        isFavorite = favoriteService.isFavorite(for: id)
    }
    
    var id: String {
        stock.id
    }
    
    var name: String {
        stock.name
    }
    
    var iconURL: String {
        stock.image
    }
    
    var symbol: String {
        stock.symbol
    }
    
    var price: String {
        "$\(String(format: "%.2f", stock.price))"
    }
    
    var change: String {
        "$\(String(format: "%.2f", stock.change)) (\(String(format: "%.2f", stock.changePercentage))% )"
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? .green : .red
    }
    
    var isFavorite: Bool = false
    
    func setFavorite() {
        isFavorite.toggle()
        
        if isFavorite {
            favoriteService.save(id: id)
        } else {
            favoriteService.remove(id: id)
        }
    }
}
