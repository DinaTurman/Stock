//
//  Stock.swift
//  Stocks
//
//  Created by Дина Турман on 26.05.2022.
//

import Foundation

struct Stock: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let price: Double
    let change: Double
    let changePercentage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case price = "current_price"
        case change = "price_change_24h"
        case changePercentage = "price_change_percentage_24h"
    }
}

struct PriceChanges: Decodable {
    let prices: [[Double]]
    let marketCaps: [[Double]]
    let totalVolumes: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps =  "market_caps"
        case totalVolumes = "total_volumes"
    }
}

/**"prices": [601 items],
 "market_caps": [601 items],
 "total_volumes": [601 items]*/
