//
//  DetailPresenter.swift
//  Stocks
//
//  Created by Дина Турман on 29.05.2022.
//

import Foundation


protocol DetailViewProtocol: AnyObject {
    func updateView() // презентер может обновить свою вью
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol DetailPresenterProtocol {
    var view: DetailViewProtocol? { get set }
    
    func loadView(id: String) // сообщает презентеру что вью загрузилась
}

final class DetailPresenter: DetailPresenterProtocol {
    private let service: StocksServiceProtocol
    private var prices: PriceChanges?


    weak var view: DetailViewProtocol?

    init(service: StocksServiceProtocol, view: StocksViewProtocol? = nil) {
        self.service = service
    }

    //презентер идет в сеть за данными, для этого нужен сервис
    func loadView(id: String) {
        view?.updateView(withLoader: true)
        service.getChange(id: id, completion: { [weak self] result in
            //вернулись с результатом
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let prices):
                self?.prices = prices
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        })
    }
}
