//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/05/01.
//

import UIKit
import Combine
import SafariServices

class FrameworkDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
//    @Published var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")
    
    var subscriptions = Set<AnyCancellable>()
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    let framework = CurrentValueSubject<AppleFramework, Never>(AppleFramework(name: "Unknown", imageName: "", urlString: "", description: ""))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
    }
    private func bind() {
        // input: 사용자 인풋을 받아서, 처리해야 할것
        //  - button 클릭되었을때 처리
        // framework -> url -> safari -> present
        buttonTapped
            .receive(on: RunLoop.main)
            .compactMap { URL(string: $0.urlString )}
            .sink { [unowned self] url in
                let safari = SFSafariViewController(url: url)
                self.present(safari, animated: true)
            }.store(in: &subscriptions)
        
        // output: data, state 변경에 따라서 UI업데이트 할것
        //  - safari 띄우기
//        $framework
        framework
            .receive(on: RunLoop.main)
            .sink { framework in
                self.imageView.image = UIImage(named: framework.imageName)
                self.titleLabel.text = framework.name
                self.descriptionLabel.text = framework.description
            }.store(in: &subscriptions)
    }
    
    @IBAction func learnMoreTapped(_ sender: Any) {
//        buttonTapped.send(framework)
        buttonTapped.send(framework.value)
    }
}
