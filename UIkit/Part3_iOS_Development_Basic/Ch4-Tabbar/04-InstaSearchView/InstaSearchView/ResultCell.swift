//
//  ResultCell.swift
//  InstaSearchView
//
//  Created by 승찬 on 2023/03/03.
//

import UIKit

class ResultCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    override func prepareForReuse() {   // 재사용 준비하는 함수
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    // 셀을 재사용하기 땨문에 위에서 기존 이미지를 nil로 초기화 하고
    // 다음 함수를 통해서 이미지를 세팅함
    func configure(_ imageName: String) {
        thumbnailImageView.image = UIImage(named: imageName)
    }
}
