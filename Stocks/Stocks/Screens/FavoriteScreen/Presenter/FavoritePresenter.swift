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
    func updateCell(for indexPath: IndexPath)
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
    private let service: StocksServiceProtocol
    
    var itemCount: Int {
        favoriteStocks.count
    }
    
    init(service: StocksServiceProtocol, view: StocksViewProtocol? = nil) {
        self.service = service
        startObservingFavoriteNotifications()
    }
    
    func loadView() {
        
        view?.updateView(withLoader: true)
        service.getStocks {[weak self] result in
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let stocks):
                self?.favoriteStocks = stocks.map { StockModel(stock: $0) }.filter { $0.isFavorite }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
         favoriteStocks[indexPath.row]
    }
    
}

extension FavoritePresenter: FavoriteUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        guard let id = notification.stockID,
              let index = favoriteStocks.firstIndex(where: { $0.id == id }) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        favoriteStocks = favoriteStocks.filter {$0.isFavorite}
        view?.updateView()
    }
}

