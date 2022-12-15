//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    var locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    
//    var weather: WeatherModel
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }


}

extension WeatherViewController: CLLocationManagerDelegate{
    @IBAction func locationPressed(_ sender: UIButton){
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat, lon)
            weatherManager.fetchWeather(lat, lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location manager error:\(error)")
    }
}

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchCity(_ sender: UIButton){
        searchTextField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text{
            weatherManager.fetchWeather(of: cityName)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Enter a city name"
            return false
        }
    }
}

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionDescription)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
        }
        
    }
    
    func didFailWithError(with error: Error) {
        print(error)
    }
}


