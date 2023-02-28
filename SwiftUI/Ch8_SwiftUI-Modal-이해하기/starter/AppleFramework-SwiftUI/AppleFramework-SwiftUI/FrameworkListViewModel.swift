//
//  FrameworkListViewModel.swift
//  AppleFramework-SwiftUI
//
//  Created by 승찬 on 2023/02/28.
//

import Foundation

final class FrameworkListViewModel: ObservableObject {
    @Published var models: [AppleFramework] = AppleFramework.list
    @Published var isShowingDetail: Bool = false
    @Published var selectedItem: AppleFramework?
}

