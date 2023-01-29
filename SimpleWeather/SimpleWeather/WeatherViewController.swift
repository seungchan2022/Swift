//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by 승찬 on 2023/01/27.
//

import UIKit

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let cities = ["Seoul", "Tokyo", "LA", "Seattle"]
    let weathers = ["cloud.fill", "sun.max.fill", "wind", "cloud.sun.rain.fill"]
    
    
    @IBAction func ChangeButtonTapped(_ sender: Any) {
        
        cityLabel.text = cities.randomElement()
        
        let imageName = weathers.randomElement()!
        weatherImageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal)
        
        let randomTemp = Int.random(in: 10..<30)
        temperatureLabel.text = "\(randomTemp)°"
        print("도시, 온도, 날씨 이미지 변경")
    }

}
