//
//  DetailViewModel.swift
//  CarrotHomeTab
//
//  Created by 승찬 on 2023/03/19.
//

import Foundation

final class DetailViewModel {
    
    let network: NetworkService
    let itemInfo: ItemInfo
    
    @Published var itemInfoDetails: ItemInfoDetails? = nil
    
    init(network: NetworkService, itemInfo: ItemInfo) {
        self.network = network
        self.itemInfo = itemInfo
    }
    
    func fecth() {
        
        // simulate network like behavior
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            self.itemInfoDetails = ItemInfoDetails(user: User.mock, item: self.itemInfo, details: ItemExtraInfo.mock)
        }
    }
}
