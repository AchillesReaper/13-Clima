//
//  WeatherManager.swift
//  Clima
//
//  Created by Donald Ho on 15/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(with error: Error)
}
struct WeatherManager{
    var delegate: WeatherManagerDelegate?
    
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=6f97312da8627eb8fea1a717cea00f17"
    
    func fetchWeather(of cityName: String){
        let cleanName = cityName.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(apiUrl)&q=\(cleanName)"
        self.performRequest(with: urlString)
    }
    
    func fetchWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees){
        let urlString = "\(apiUrl)&lat=\(latitude)&lon=\(longitude)"
        self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(with: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decodedData.name
            let temperature = decodedData.main.temp
            let conditionId = decodedData.weather[0].id
            return WeatherModel(cityName, temperature, conditionId)
        }catch{
            delegate?.didFailWithError(with: error)
            return nil
        }
        
    }
}
