//
//  WeatherModel.swift
//  Clima
//
//  Created by Donald Ho on 15/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//
// WeatherModel renders the output data

import Foundation

struct WeatherModel{
    let cityName: String
    let temperature: Double
    let conditionId: Int
    
    init(_ cityName: String, _ temperature: Double, _ conditionId: Int) {
        self.cityName = cityName
        self.temperature = temperature
        self.conditionId = conditionId
    }
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    var conditionDescription: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
