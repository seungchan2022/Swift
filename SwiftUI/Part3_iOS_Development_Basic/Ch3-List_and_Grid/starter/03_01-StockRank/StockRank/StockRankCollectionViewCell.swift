//
//  StockRankCollectionViewCell.swift
//  StockRank
//
//  Created by 승찬 on 2023/03/02.
//

import UIKit

class StockRankCollectionViewCell: UICollectionViewCell {
    
    // collectionView를 표현하기 위해 UICollectionViewCell을 만듬
    
    // uicomponent 연결
    // uicomponent에 데이터를 업데이트 하는 코드를 넣자
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var companyIconImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPrice: UILabel!
    @IBOutlet weak var diffLabel: UILabel!
    
    func configure(_ stock: StockModel) {
        rankLabel.text = "\(stock.rank)"
        companyIconImageView.image = UIImage(named: stock.imageName)
        companyNameLabel.text = stock.name
        companyPrice.text = "\(converToCurrencyFormat(price: stock.price)) 원"
        
        diffLabel.textColor = stock.diff > 0 ? UIColor.systemRed : UIColor.systemBlue
        diffLabel.text = "\(stock.diff)%"
    }
    
    func converToCurrencyFormat(price: Int) -> String {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        numFormatter.maximumFractionDigits = 0
        let result = numFormatter.string(from: NSNumber(value: price)) ?? "n/a"
        return result
    }
}
