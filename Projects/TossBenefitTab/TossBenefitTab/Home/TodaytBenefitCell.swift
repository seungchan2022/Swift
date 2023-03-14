//
//  TodaytBenefitCell.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//

import UIKit

class TodaytBenefitCell: UICollectionViewCell {
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3 )
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        
        self.ctaButton.layer.masksToBounds = true
        self.ctaButton.layer.cornerRadius = 10
    }
     
    
    func configure(item: Benefit) {
        titleLabel.text = item.title
        ctaButton.setTitle(item.ctaTitle, for: .normal)
    }
}
