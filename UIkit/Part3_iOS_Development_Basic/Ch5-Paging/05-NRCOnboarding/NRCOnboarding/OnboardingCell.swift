//
//  OnboardingCell.swift
//  NRCOnboarding
//
//  Created by 승찬 on 2023/03/03.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ message: OnboardingMessage) {
        thumbnailImageView.image = UIImage(named: message.imageName)
        nameLabel.text = message.title
        descriptionLabel.text = message.description
    }
}
