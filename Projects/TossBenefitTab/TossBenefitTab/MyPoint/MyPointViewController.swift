//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by 승찬 on 2023/03/14.
//

import UIKit

class MyPointViewController: UIViewController {
    
    @IBOutlet weak var pointLabel: UILabel!
    
    var point: MyPoint = .defalut
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
    }
}
