//
//  WeatherResponse.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import Foundation

struct WeatherResponse : Decodable {
    var list: [Forecast]
}


struct Forecast: Decodable {
    var dt: Int
    var main : Main
    var weather: [Weather]
}

struct Main: Decodable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}

struct Weather: Decodable {
    var main: String
    var description: String
    var icon: String
}
