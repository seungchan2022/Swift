//
//  BenefitListViewModel.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/15.
//

import Foundation
import Combine

final class BenefitListViewModel {
    
    // 데이터가 세팅이 되면 뷰를 자동 렌더링해서 보여준다
    @Published var todaySectionItems: [AnyHashable] = []
    @Published var otherSectionItems: [AnyHashable] = []
    
    // user action
    let benefitDidTapped = PassthroughSubject<Benefit, Never>()
    let pointDidTapped = PassthroughSubject<MyPoint, Never>()
    
    func fetchItems() {
        // => 메인 쓰레드에서 0.5초 뒤에 클로져 안을 실행한다
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.todaySectionItems = TodaySectionItem(point: MyPoint.default, today: .today).sectionItems
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.otherSectionItems = Benefit.others
        }
    }
}
