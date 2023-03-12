//
//  FrameworkListViewModel.swift
//  AppleFramework-SwiftUI
//
//  Created by 승찬 on 2023/03/12.
//

import Foundation
import SwiftUI

final class FrameworkListViewModel: ObservableObject {
    @Published var models: [AppleFramework] = AppleFramework.list
    @Published var isShowingDetail: Bool = false
    @Published var isSelectedItem: AppleFramework?
}
