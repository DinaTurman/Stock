//
//  DetailModel.swift
//  Stocks
//
//  Created by Дина Турман on 29.05.2022.
//

import Foundation


protocol DetailModelProtocol {
    var priceChange: PriceChanges { get }

}


final class DetailModel: DetailModelProtocol {
     var priceChange: PriceChanges
    
    init(stock: StockModelProtocol, priceChange: PriceChanges) {
        self.priceChange = priceChange
    }


}
