//
//  StocksService.swift
//  Stocks
//
//  Created by Дина Турман on 26.05.2022.
//

import Foundation



enum StockRouter: Router {
    case stocks(currency: String, count: String)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
           return "/api/v3/coins/markets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency": currency, "per_page": count]
        }
    }
}

protocol StocksServiceProtocol {
    func getStocks(carrency: String, count: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getStocks(carrency: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion: @escaping(Result<[Stock], NetworkError>) -> Void)
}

extension StocksServiceProtocol {
    func getStocks(carrency: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        getStocks(carrency: carrency, count: "100", completion: completion)
    }
    func getStocks(completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        getStocks(carrency: "usd", completion: completion)
    }
}

final class StocksService: StocksServiceProtocol {
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks(carrency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StockRouter.stocks(currency: carrency, count: count), completion: completion)
    }
}