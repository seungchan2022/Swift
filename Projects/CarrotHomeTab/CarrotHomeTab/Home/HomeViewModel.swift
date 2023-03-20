//
//  HomeViewModel.swift
//  CarrotHomeTab
//
//  Created by 승찬 on 2023/03/17.
//

import Foundation
import Combine

final class HomeViewModel {
    
    let network: NetworkService
    
    // 네크워크를 통해서 가져온 아이템들
    @Published var items: [ItemInfo] = []
    var subscriptions = Set<AnyCancellable>()
    
    let itemTapped = PassthroughSubject<ItemInfo, Never>()

    init(network: NetworkService) {
        self.network = network
    }
    
    func fetch() {
        // 리소스는 ItemInfo를 가져올 것
        let resource: Resource<[ItemInfo]> = Resource(
            base: "https://my-json-server.typicode.com/",
            path: "cafielo/demo/products",
            params: [:],
            header: ["Content-Type": "application/json"]
        )
            
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("===> error: \(error)")
                case .finished:
                    print("===> finished")
                }
            } receiveValue: { items in
                self.items = items
            }.store(in: &subscriptions)
    }
}
