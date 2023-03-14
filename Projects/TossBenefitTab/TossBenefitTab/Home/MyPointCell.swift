//
//  MyPointCell.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//

import UIKit

class MyPointCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    func configure(item: MyPoint) {
        iconView.image =  UIImage(named: "ic_point")
        descriptionLabel.text = "내 포인트"
        pointLabel.text = "\(item.point) 원"
    }
}
