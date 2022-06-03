//
//  FavoriteUpdateService.swift
//  Stocks
//
//  Created by Дина Турман on 03.06.2022.
//

import Foundation

@objc protocol FavoriteUpdateServiceProtocol {
    func setFavorite(notification: Notification)
}

extension FavoriteUpdateServiceProtocol{
    func startObservingFavoriteNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(setFavorite), name: NSNotification.Name.favoriteNotification, object: nil)
    }
}

extension NSNotification.Name {
    static let favoriteNotification = NSNotification.Name("favorite")
}

extension Notification {
    var stockID: String? {
        guard let userInfo = userInfo,
              let id = userInfo["id"] as? String else { return nil}
        
       return id
    }
}
