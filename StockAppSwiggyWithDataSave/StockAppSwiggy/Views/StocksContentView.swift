//
//  StocksContentView.swift
//  StockAppSwiggy
//
//  Created by Mohammad Shariq on 24/07/25.
//

import SwiftUI

struct StocksContentView: View {

    @StateObject private var viewModel = StockViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.stocks) { stock in
                HStack {
                    VStack(alignment: .leading) {
                        Text(stock.sid)
                            .font(.headline)
                        Text("₹\(stock.price, specifier: "%.2f")")
                            .foregroundColor(stock.change >= 0 ? .green : .red)
                    }
                    Spacer()
                    Image(systemName: stock.change >= 0 ? "arrow.up" : "arrow.down")
                        .foregroundColor(stock.change >= 0 ? .green : .red)
                    
                    Button(action: {
                        viewModel.toggleWishlist(for: stock.sid)
                    }) {
                        Image(systemName: viewModel.isWishlisted(stock.sid) ? "heart.fill" : "heart")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Stocks")
            .toolbar {
                NavigationLink("Wishlist") {
                    WishlistView(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    StocksContentView()
}
