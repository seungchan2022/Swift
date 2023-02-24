//
//  FrameworkDetailViewModel.swift
//  AppleFramework
//
//  Created by 승찬 on 2023/02/24.
//

import Foundation
import Combine

final class FrameworkDetailViewModel {
    
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    
    // Data -> Output
    let framework: CurrentValueSubject<AppleFramework, Never>

    // UserAction -> Input
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    func learnMoreTapped() {
        buttonTapped.send(framework.value)
    }

    
}
