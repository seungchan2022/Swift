//
//  FrameworkDetailViewModel.swift
//  AppleFramework
//
//  Created by 승찬 on 2023/03/09.
//

import Foundation
import Combine


final class FrameworkDetailViewModel {
    
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    
    // Data => Output
    let framework: CurrentValueSubject<AppleFramework, Never> 
    
    // User Action => Input
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()

    func learnMoreTapped() {
        buttonTapped.send(framework.value)
    }
}


