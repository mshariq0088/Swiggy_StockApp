//
//  CacheManager.swift
//  StockAppSwiggy
//
//  Created by Mohammad Shariq on 25/07/25.
//

import Foundation

struct CacheManager {
    static func save<T: Encodable>(_ object: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(object) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func load<T: Decodable>(forKey key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
}
