//
//  DetailStockModel.swift
//  Stocks
//
//  Created by Дина Турман on 02.06.2022.
//


import Foundation


protocol DetailStockModelProtocol {
    var priceChange: Charts { get }

}


final class DetailStockModel: DetailStockModelProtocol {
     var priceChange: Charts
    
    init(stock: StockModelProtocol, priceChange: Charts) {
        self.priceChange = priceChange
    }
}
