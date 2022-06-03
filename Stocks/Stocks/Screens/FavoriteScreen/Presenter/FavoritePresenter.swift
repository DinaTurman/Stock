//
//  FavoritePresenter.swift
//  Stocks
//
//  Created by Дина Турман on 03.06.2022.
//

import Foundation

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func updateView() // презентер может обновить свою вью
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol FavoritePresenterProtocol {
    
    var view: FavoriteViewProtocol? { get set }
    var itemCount: Int { get }
    
    func loadView() // сообщает презентеру что вью загрузилась
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class FavoritePresenter: FavoritePresenterProtocol {
    var favoriteStocks: [StockModelProtocol] = []
    weak var view: FavoriteViewProtocol?
    
    var itemCount: Int {
        favoriteStocks.count
    }
    
    //презентер идет в сеть за данными, для этого нужен сервис
    func loadView() {
        view?.updateView()
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        favoriteStocks[indexPath.row]
    }
}

