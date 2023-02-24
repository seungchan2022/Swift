//
//  FrameworkListViewModel.swift
//  AppleFramework
//
//  Created by 승찬 on 2023/02/24.
//

import Foundation
import Combine

final class FrameworkListViewModel {
    
    init(items: [AppleFramework], selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(items)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
    // Data -> Output
    let items: CurrentValueSubject<[AppleFramework], Never>
    let selectedItem: CurrentValueSubject<AppleFramework?, Never>

    // UserAction -> Input
    func didSelect(at indexpath: IndexPath) {
        let item = items.value[indexpath.item]
        selectedItem.send(item)
    }
}
