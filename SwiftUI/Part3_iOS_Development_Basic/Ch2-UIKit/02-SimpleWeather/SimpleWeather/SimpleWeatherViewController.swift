//
//  SimpleWeatherViewController.swift
//  SimpleWeather
//
//  Created by 승찬 on 2023/03/02.
//

import UIKit

class SimpleWeatherViewController: UIViewController {
    
    let cities = ["Seoul", "Tokyo", "LA", "Jeju"]
    let weathers = ["sun.max.fill", "clould.fill", "wind", "sparkle"]
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weather: UIImageView!
    @IBOutlet weak var temp: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ChangeCity(_ sender: Any) {
//        print("Change City")
        cityLabel.text = cities.randomElement()!
        
        let imageName = weathers.randomElement()!
        weather.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal)
        
        let randomTemp = Int.random(in: 10..<30)
        temp.text = "\(randomTemp)°"
        
    }
    
}
