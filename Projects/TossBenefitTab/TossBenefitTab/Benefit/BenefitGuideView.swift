//
//  BenefitGuideView.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//


// storyboard를 코드로 표현(혜택 상세뷰의 guide)
import UIKit

final class BenefitGuideView: UIView {
    
    lazy var icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {  // 만든 view를 GuideView안에 추가
        addSubview(icon)
        addSubview(title)
        // OutoLayout
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),  // leading
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),  // C.V
            icon.widthAnchor.constraint(equalToConstant: 30),       // width
            icon.heightAnchor.constraint(equalToConstant: 30),       // height
        ])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
        ])
    }
}
