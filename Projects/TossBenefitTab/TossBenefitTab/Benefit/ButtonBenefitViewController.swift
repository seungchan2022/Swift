//
//  ButtonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//

import UIKit

class ButtonBenefitViewController: UIViewController {

    var benefit: Benefit = .today
    var benefitDetails: BenefitDetails = .default
    
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var vStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addGuides()
        // 각 버튼 마다 나오는 ctatitle이 다름
        ctaButton.setTitle(benefit.ctaTitle, for: .normal)
    }
    
    private func setupUI() {
        ctaButton.layer.masksToBounds = true
        ctaButton.layer.cornerRadius = 5
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addGuides() {
        // BenefitDetails의 guides가 2개로 되어있으므로 map를 사용해서 표현
        let guideViews: [BenefitGuideView] = benefitDetails.guides.map { guide in
            let guideView = BenefitGuideView(frame: .zero)
            guideView.icon.image = UIImage(systemName: guide.iconName)
            guideView.title.text = guide.guide
            return guideView
        }
        
        // stackView의 오토레이아웃
        guideViews.forEach { view in
            self.vStackView.addArrangedSubview(view)
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
}
