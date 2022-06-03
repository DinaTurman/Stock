//
//  DetailPresenter.swift
//  Stocks
//
//  Created by Дина Турман on 29.05.2022.
//

import Foundation


protocol DetailStockViewProtocol: AnyObject {
    func updateView() // презентер может обновить свою вью
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol DetailStockPresenterProtocol {
    //var view: DetailStockViewProtocol? { get set }
    var favoriteButtonIsSelected: Bool { get }
    var title: String { get }
    var subtitle: String { get }
    var price: String { get }
    var change: String { get }
    var id: String { get }
    
    func loadView() // сообщает презентеру что вью загрузилась
    func favoriteButtonTapped()
}



final class DetailStockPresenter: DetailStockPresenterProtocol {
    private let service: StocksServiceProtocol
    //private var prices: PriceChanges?
    private let model: StockModelProtocol
    weak var view: DetailStockViewProtocol?
    
    var favoriteButtonIsSelected: Bool {
        model.isFavorite
    }
    
    var title: String {
        model.symbol
    }
    
    var subtitle: String {
        model.name
    }
    
    var price: String {
        model.price
    }
    
    var change: String {
        model.change
    }
    
    var id: String {
        model.id
    }

    init(model: StockModelProtocol, service: StocksServiceProtocol) {
        self.model = model
        self.service = service
    }

    func loadView() {
        view?.updateView(withLoader: true)
        
        service.getCharts(id: model.id, currency: "usd", days: "100", isDaily: true) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let charts):
                self?.view?.updateView()
                print("Charts count - ", charts.prices.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func favoriteButtonTapped() {
        model.setFavorite()
    }
}
