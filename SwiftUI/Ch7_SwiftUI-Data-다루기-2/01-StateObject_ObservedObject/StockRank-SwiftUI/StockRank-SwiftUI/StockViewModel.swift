//
//  StockViewModel.swift
//  StockRank-SwiftUI
//
//  Created by 승찬 on 2023/03/11.
//

import Foundation

final class StockViewModel: ObservableObject {
    @Published var models: [StockModel] = StockModel.list
    
    var numOfFavorites: Int {
        let favoriteStocks = models.filter { $0.isFavorite }
        return favoriteStocks.count
    }
}
