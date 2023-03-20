//
//  DetailViewController.swift
//  CarrotHomeTab
//
//  Created by 승찬 on 2023/03/17.
//

import UIKit
import Combine
import Kingfisher

// 상단 네비게이션 바 rightbarbuttonItem
// 하단 채팅하기 뷰 작업

class DetailViewController: UIViewController {

    // User
    @IBOutlet weak var userThumbnail: UIImageView!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userTemperature: UILabel!
    
    // Item
    @IBOutlet weak var itemThumbnail: UIImageView!
    @IBOutlet weak var itemInfotitle: UILabel!
    @IBOutlet weak var itemInfoDescription: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var viewModel: DetailViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        bind()
        viewModel.fecth()
    }
    
    private func setupUI() {
        userThumbnail.layer.masksToBounds = true
        userThumbnail.layer.cornerRadius = 40
        
    }
    
    private func bind() {
        viewModel.$itemInfoDetails
            .compactMap { $0 }  // nil이 아닌 경우에만
            .receive(on: RunLoop.main)
            .sink { details in
                self.userThumbnail.kf.setImage(with: URL(string: details.user.thumnail))
                self.userNickName.text = details.user.name
                self.userLocation.text = details.user.location
                self.userTemperature.text = "\(details.user.temperature)°C"
                self.itemThumbnail.kf.setImage(with: URL(string: details.item.thumbnailURL))
                self.itemInfotitle.text = details.item.title
                self.itemInfoDescription.text = details.details.descriptions
                self.itemPriceLabel.text = "\(self.formatNumber(details.item.price)) 원"
            }.store(in: &subscriptions)
    }
    
    private func configureNavigationBar() {
        
        let moreConfig = CustomBarItemConfiguration(
            image: UIImage(systemName:  "ellipsis"),
            handler: { print("---> more tapped") }
        )
        let moreItem = UIBarButtonItem.generate(with: moreConfig, width: 30)
    
        let shareConfig = CustomBarItemConfiguration(
            image: UIImage(systemName: "square.and.arrow.up"),
            handler: { print("---> share tapped") }
        )
        let shareItem = UIBarButtonItem.generate(with: shareConfig, width: 30)
        
        navigationItem.rightBarButtonItems = [moreItem, shareItem]
        navigationItem.backButtonDisplayMode = .minimal
    }
}

extension DetailViewController {
    private func formatNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let result = formatter.string(from: NSNumber(integerLiteral: price)) ?? ""
        return result
     }
}
