//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 승찬 on 2023/02/13.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
