//
//  MyPointViewModel.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/15.
//

import Foundation
import Combine

final class MyPointViewModel {
    @Published var point: MyPoint 
    
    init(point: MyPoint) {
        self.point = point
    }
}
