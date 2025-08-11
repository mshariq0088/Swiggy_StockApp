//
//  WishlistView.swift
//  StockAppSwiggy
//
//  Created by Mohammad Shariq on 24/07/25.
//

import SwiftUI

struct WishlistView: View {
    @ObservedObject var viewModel: StockViewModel

    var body: some View {
        List(viewModel.wishlistStocks) { stock in
            VStack(alignment: .leading) {
                Text(stock.sid)
                    .font(.headline)
                Text("₹\(stock.price, specifier: "%.2f")")
            }
        }
        .navigationTitle("Wishlist")
    }
}

//#Preview {
//    WishlistView(viewModel: )
//}
