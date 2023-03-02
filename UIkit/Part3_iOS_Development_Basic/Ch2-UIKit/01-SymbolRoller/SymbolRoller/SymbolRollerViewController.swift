//
//  SymbolRollerViewController.swift
//  SymbolRoller
//
//  Created by 승찬 on 2023/03/02.
//

import UIKit

class SymbolRollerViewController: UIViewController {
    
    let symbols: [String] = ["sun.max", "moon", "cloud.heavyrain.fill","wind", "snowflake"]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buton: UIButton!
    
    // - 심볼에서 하나를 임의로 추출해서
    //   이미지와 텍스트 출력
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        buton.tintColor = UIColor.systemPink
    }
    
    func reload() {
        let symbol = symbols.randomElement()!
        imageView.image = UIImage(systemName: symbol)
        label.text = symbol
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        print("button tapped")
        reload()
    }
    
}
