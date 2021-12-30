//
//  WeatherViewModel.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import Foundation

class WeatherViewModel: Identifiable {
    
    var id = UUID()
    private let weather: Forecast
    
    init(weather: Forecast) {
        self.weather = weather
    }
 
    var timestamp: TimeInterval {
        return TimeInterval(weather.dt)
    }
    
    var temperature: String {
        return weather.main.temp.toTemps()
    }
    
    var min: String {
        return weather.main.temp_min.toTempsWithValue(value: "min: ")
    }
    
    var max: String {
        return weather.main.temp_max.toTempsWithValue(value: "max: ")
    }
    
    var mainDescr: String {
        return weather.weather.first?.main ?? ""
    }
    
    var desc: String {
        return weather.weather.first?.description ?? ""
    }
    
    var iconstr: String {
        return weather.weather.first?.icon ?? ""
    }

}


extension Double {
    func toTemps()-> String {
        let int: Int = Int(self)
        let celcius = "°c"
        
        return String(int) + celcius
    }
    
    func toTempsWithValue(value: String)-> String {
        return value + self.toTemps()
    }
}
