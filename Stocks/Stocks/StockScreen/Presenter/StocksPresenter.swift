//
//  StocksPresenter.swift
//  Stocks
//
//  Created by Дина Турман on 28.05.2022.
//

import Foundation

protocol StocksViewProtocol: AnyObject {
    func updateView() // презентер может обновить свою вью
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StocksPresenterProtocol {
    var view: StocksViewProtocol? { get set }
    var itemCount: Int { get }
    
    func loadView() // сообщает презентеру что вью загрузилась
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StocksPresenter: StocksPresenterProtocol {
    private let service: StocksServiceProtocol
    private var stocks: [StockModelProtocol] = []
    
    var itemCount: Int {
        stocks.count
    }
    
    weak var view: StocksViewProtocol?
    
    init(service: StocksServiceProtocol, view: StocksViewProtocol? = nil) {
        self.service = service
    }
    
    //презентер идет в сеть за данными, для этого нужен сервис
    func loadView() {
        view?.updateView(withLoader: true)
        service.getStocks {[weak self] result in
            //вернулись с результатом
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let stocks):
                self?.stocks = stocks.map { StockModel(stock: $0) }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        stocks[indexPath.row]
    }
}


/**protocol StocksPresenterProtocol {
 var view: StocksViewProtocol? { get set }
 var itemsCount: Int { get }
 
 func loadView()
 func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StocksPresenter: StocksPresenterProtocol {
 private let service: StocksServiceProtocol
 private var stoks: [StockModelProtocol] = []
 
 var itemsCount: Int {
     stoks.count
 }
 
 init(service: StocksServiceProtocol) {
     self.service = service
 }
 
 weak var view: StocksViewProtocol?
 
 func loadView() {
     // Идем в сеть и показываем лоадер
     view?.updateView(withLoader: true)
     
     service.getStocks { [weak self] result in
         // Возвращаемся с данными и убираем лоадер
         self?.view?.updateView(withLoader: false)
         
         switch result {
         case .success(let stocks):
             self?.stoks = stocks.map { StockModel(stock: $0) }
             print(stocks[2].id)
             self?.view?.updateView()
         case .failure(let error):
             self?.view?.updateView(withError: error.localizedDescription)
         }
     }
 }
 
 func model(for indexPath: IndexPath) -> StockModelProtocol {
     stoks[indexPath.row]
 }
}
*/
