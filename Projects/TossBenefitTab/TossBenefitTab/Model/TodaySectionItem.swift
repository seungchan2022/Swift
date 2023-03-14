//
//  TodaySectionItem.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//

import Foundation


struct TodaySectionItem {
    var point: MyPoint
    let today: Benefit
    
    var sectionItems: [AnyHashable] {
        return [point, today]
    }
}

extension TodaySectionItem {
    static let mock = TodaySectionItem(
        point: MyPoint(point: 0),
        today: Benefit.walk
    )
}
