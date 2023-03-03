//
//  NewsFeedCell.swift
//  InstaSearchView
//
//  Created by 승찬 on 2023/03/03.
//

import UIKit

class NewsFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil      // 초기화
    }
    
    func configure(_ imageName: String) {
        thumbnailImageView.image = UIImage(named: imageName)       // 이미지 세팅
    }
}
