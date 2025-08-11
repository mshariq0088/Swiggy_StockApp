//
//  StockModel.swift
//  StockAppSwiggy
//
//  Created by Mohammad Shariq on 24/07/25.
//

import Foundation

struct StockModel: Decodable {
    let success: Bool
    let data: [StockItem]
}

// MARK: - Each Stock Item
struct StockItem: Codable, Identifiable {
    var id: String { sid }
    let sid: String
    let price: Double
    let close: Double
    let change: Double
    let high: Double
    let low: Double
    let volume: Int
    let date: String
}
