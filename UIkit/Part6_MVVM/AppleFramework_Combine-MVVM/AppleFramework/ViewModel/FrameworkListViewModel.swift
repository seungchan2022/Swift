//
//  FrameworkListViewModel.swift
//  AppleFramework
//
//  Created by 승찬 on 2023/03/09.
//

import Foundation
import Combine

// 각 viewController에 대한 viewModel을 만들고 viewController는 view레이어 이므로 model(data)을 알면 안된다.

final class FrameworkListViewModel {
    
    init(items: [AppleFramework], selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(items)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
    // Data => Output
    let items: CurrentValueSubject<[AppleFramework], Never>
    let selectedItem: CurrentValueSubject<AppleFramework?, Never>   // 하나만 선택되는 것이므로
    
    // User Action => Input
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    
    func didSelect(at indexPath: IndexPath) {
        // 선택된 아이템을 찾아서 보내주면됌 
        let item = items.value[indexPath.item]
        selectedItem.send(item)
    }
}
