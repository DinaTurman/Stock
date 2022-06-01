//
//  StocksService.swift
//  Stocks
//
//  Created by Дина Турман on 26.05.2022.
//

import Foundation

//https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=600&interval=daily
//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=100

enum StockRouter: Router {
    case stocks(currency: String, count: String)
    case detail(id: String, currency: String, days: String, interval: String)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
           return "/api/v3/coins/markets"
        case .detail(let id, _, _, _):
            return "/api/v3/coins/\(id)/market_chart"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks:
            return .get
        case .detail:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency": currency, "per_page": count]
        case .detail(_ , let currency, let days, let interval):
            return ["vs_currency": currency, "days": days, "interval": interval ]
        }
    }
}

protocol StocksServiceProtocol {
    func getStocks(carrency: String, count: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getStocks(carrency: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getChange(id: String, currency: String, days: String, interval: String, completion: @escaping(Result<PriceChanges, NetworkError>) -> Void)
    func getChange(id: String, days: String, interval: String, completion: @escaping(Result<PriceChanges, NetworkError>) -> Void)
    func getChange(id: String, interval: String, completion: @escaping(Result<PriceChanges, NetworkError>) -> Void)
    func getChange(id: String, completion: @escaping(Result<PriceChanges, NetworkError>) -> Void)
}

extension StocksServiceProtocol {
    func getStocks(carrency: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        getStocks(carrency: carrency, count: "100", completion: completion)
    }
    func getStocks(completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        getStocks(carrency: "usd", completion: completion)
    }
    func getChange(id: String, days: String, interval: String, completion: @escaping(Result<PriceChanges, NetworkError>) -> Void) {
        getChange(id: id, currency: "usd", days: days, interval: interval, completion: completion)
    }
    func getChange(id: String, interval: String, completion: @escaping(Result<PriceChanges, NetworkError>) -> Void) {
        getChange(id: id, days: "600", interval: interval, completion: completion)
    }
    
    func getChange(id: String, completion: @escaping(Result<PriceChanges, NetworkError>) -> Void) {
        getChange(id: id, interval: "daily", completion: completion)
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
    
    func getChange(id: String, currency: String, days: String, interval: String, completion: @escaping (Result<PriceChanges, NetworkError>) -> Void) {
        client.execute(with: StockRouter.detail(id: id, currency: currency, days: days, interval: interval), completion: completion)
    }
}
