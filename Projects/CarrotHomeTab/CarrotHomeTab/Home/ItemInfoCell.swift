//
//  ItemInfoCell.swift
//  CarrotHomeTab
//
//  Created by 승찬 on 2023/03/19.
//

import UIKit
import Kingfisher

class ItemInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numofChatLabel: UILabel!
    @IBOutlet weak var numofLikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail.layer.masksToBounds = true
        thumbnail.layer.cornerRadius = 10
        thumbnail.tintColor = .systemGray
    }
    
    func configure(item: ItemInfo) {
        titleLabel.text = item.title
        descriptionLabel.text = item.location
        priceLabel.text = "\(formatNumber(item.price)) 원"
        numofChatLabel.text = "\(item.numOfChats)"
        numofLikeLabel.text = "\(item.numOfLikes)"
        thumbnail.kf.setImage(
            with: URL(string: item.thumbnailURL)!,
            placeholder: UIImage(systemName: "heart")   // URL이 잘못되었을때 표시되는 것
        )
    }
    
    private func formatNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let result = formatter.string(from: NSNumber(integerLiteral: price)) ?? ""
        return result
     }
}
