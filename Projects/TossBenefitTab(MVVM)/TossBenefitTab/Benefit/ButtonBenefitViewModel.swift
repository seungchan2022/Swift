//
//  ButtonBenefitViewModel.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/15.
//

import Foundation


final class ButtonBenefitViewModel {
    @Published var benefit: Benefit
    @Published var benefitDeatils: BenefitDetails?
    
    init(benefit: Benefit) {
        self.benefit = benefit
    }
    
    func fetchDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.benefitDeatils = .default
        }
    }
}

