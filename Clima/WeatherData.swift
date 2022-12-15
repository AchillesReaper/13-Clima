//
//  WeatherData.swift
//  Clima
//
//  Created by Donald Ho on 15/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//
// WeatherData handles the data from API

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable{
    let id: Int
    let main: String
    let description: String
    let icon: String
}
