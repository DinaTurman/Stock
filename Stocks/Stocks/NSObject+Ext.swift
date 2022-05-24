//
//  NSObject+Ext.swift
//  Stocks
//
//  Created by Дина Турман on 24.05.2022.
//

import Foundation

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}
