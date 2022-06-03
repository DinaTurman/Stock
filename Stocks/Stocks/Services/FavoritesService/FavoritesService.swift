//
//  FavoritesService.swift
//  Stocks
//
//  Created by Дина Турман on 01.06.2022.
//

import Foundation

protocol FavoritesServiceProtocol {
    func save(id: String)
    func remove(id: String)
    func isFavorite(for id: String) -> Bool
}
