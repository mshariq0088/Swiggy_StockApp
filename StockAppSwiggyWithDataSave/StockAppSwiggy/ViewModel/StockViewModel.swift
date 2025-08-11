//
//  StockViewModel.swift
//  StockAppSwiggy
//
//  Created by Mohammad Shariq on 24/07/25.
//


import Foundation
import Combine

class StockViewModel: ObservableObject {
    @Published var stocks: [StockItem] = []
    @Published var wishlist: [String] = []

    private var timer: Timer?
    private let apiURL = "https://api.tickertape.in/stocks/quotes?sids=RELI,TCS,ITC,HDBK,INFY"
    private let cacheKey = "cachedStocks"
    private let wishlistKey = "wishlist"

    init() {
        loadCachedData()
        loadWishlist()
        startPolling()
    }

    func startPolling() {
        fetchStock()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.fetchStock()
        }
    }

    func fetchStock() {
        guard let url = URL(string: apiURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard
                let data = data,
                let result = try? JSONDecoder().decode(StockModel.self, from: data)
            else { return }

            DispatchQueue.main.async {
                self.stocks = result.data
                CacheManager.save(self.stocks, forKey: self.cacheKey)
            }
        }.resume()
    }

    func loadCachedData() {
        if let cached: [StockItem] = CacheManager.load(forKey: cacheKey) {
            self.stocks = cached
        }
    }

    func toggleWishlist(for sid: String) {
        if wishlist.contains(sid) {
            wishlist.removeAll { $0 == sid }
        } else {
            wishlist.append(sid)
        }
        UserDefaults.standard.set(wishlist, forKey: wishlistKey)
    }

    func isWishlisted(_ sid: String) -> Bool {
        wishlist.contains(sid)
    }

    func loadWishlist() {
        self.wishlist = UserDefaults.standard.stringArray(forKey: wishlistKey) ?? []
    }

    var wishlistStocks: [StockItem] {
        stocks.filter { wishlist.contains($0.sid) }
    }
}


