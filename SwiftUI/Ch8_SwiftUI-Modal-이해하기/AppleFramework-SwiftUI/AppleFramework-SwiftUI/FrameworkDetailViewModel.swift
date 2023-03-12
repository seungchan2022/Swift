//
//  FrameworkDetailViewModel.swift
//  AppleFramework-SwiftUI
//
//  Created by 승찬 on 2023/03/12.
//

import Foundation
import SwiftUI

final class FrameworkDetailViewModel: ObservableObject {
    @Published var framework: AppleFramework
    @Published var isSafariPresented: Bool = false
    
    init(framework: AppleFramework) {
        self.framework = framework
    }
}
