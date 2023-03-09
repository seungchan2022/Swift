//
//  SearchViewModel.swift
//  GithubUserSearch
//
//  Created by 승찬 on 2023/03/09.
//

import Foundation
import Combine

final class SearchViewModel {
    
    let network: NetworkService
    init(network: NetworkService) {
        self.network = network
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    // Data => Output
    @Published private(set) var users = [SearchResult]()
    
    // User Action => Input
    func search(keyword: String) {
        let resource: Resource<SearchUserResponse> = Resource(
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword],
            header: ["Content-Type": "application/json"]
        )
    
        network.load(resource)
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &subscriptions)
    }
}
