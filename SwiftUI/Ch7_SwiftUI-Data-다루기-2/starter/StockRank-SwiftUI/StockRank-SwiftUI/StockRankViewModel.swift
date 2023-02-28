//
//  StockRankViewModel.swift
//  StockRank-SwiftUI
//
//  Created by 승찬 on 2023/02/28.
//

import Foundation

// @StateObject, @ObserveObject를 사용하려면 ObservableObject 프로토콜을 사용해서 class를 생성해야된다.
final class StockRankViewModel: ObservableObject {
    @Published var models: [StockModel] = StockModel.list
    
    var numOfFavorites: Int {
        let favoriteStocks =  models.filter { $0.isFavorite }
        return favoriteStocks.count
    }
}
