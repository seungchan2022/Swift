//
//  MyPoint.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//

import Foundation

struct MyPoint: Hashable {
    var point: Int
}

extension MyPoint {
    static let `defalut` = MyPoint(point: 0)
}
