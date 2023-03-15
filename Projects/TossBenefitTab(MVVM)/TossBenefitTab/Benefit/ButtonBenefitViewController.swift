//
//  ButtonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/15.
//

import UIKit
import Combine

class ButtonBenefitViewController: UIViewController {
    
    var viewModel: ButtonBenefitViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var vStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.fetchDetails()
    }
    
    private func setupUI() {
        ctaButton.layer.masksToBounds = true
        ctaButton.layer.cornerRadius = 5
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func bind() {
        // output: data
        viewModel.$benefit  // benefit 데이터로 ctaTitle을 바꿈
            .receive(on: RunLoop.main)
            .sink { benefit in
                // 각 버튼 마다 나오는 ctaTitle이 다름
                self.ctaButton.setTitle(benefit.title, for: .normal)
            }.store(in: &subscriptions)
        
        viewModel.$benefitDeatils
            .compactMap { $0 }  // nil인 경우는 받지 않음
            .receive(on: RunLoop.main)
            .sink { details in
                self.addGuides(details: details)
            }.store(in: &subscriptions)
    }
    
    // => stackView에 다가 동적으로 guideView를 넣어주는것
    private func addGuides(details: BenefitDetails) {
        let guideViews: [BenefitGuideView] = details.guides.map { guide in
            let guideView = BenefitGuideView(frame: .zero)
            guideView.icon.image = UIImage(systemName: guide.iconName)
            guideView.title.text = guide.guide
            return guideView
        }
        
        // stack의 오토레이 아웃
        guideViews.forEach { view in
            self.vStack.addArrangedSubview(view)
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
}
