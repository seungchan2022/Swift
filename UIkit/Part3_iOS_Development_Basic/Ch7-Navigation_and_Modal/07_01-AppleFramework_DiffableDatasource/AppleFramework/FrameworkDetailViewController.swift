//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by 승찬 on 2023/03/06.
//

import UIKit
import SafariServices

// 새로운 storyboard를 만들어서 사용
class FrameworkDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var framework: AppleFramework = AppleFramework(name: "Unkown", imageName: "", urlString: "", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        imageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
        descriptionLabel.text = framework.description
    }
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        guard let url = URL(string: framework.urlString) else {
            return
        }
        
        // safari를 띄우려면 import SafariServices를 해야된다.
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
}
