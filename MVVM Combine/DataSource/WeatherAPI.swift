//
//  WeatherAPI.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import Foundation
import Combine


class weatherApi: WeatherProtocol, ObservableObject {
    
    
    private var key = /* Enter your apiKey*/
    private var session = URLSession.shared
    
    
    func getWeather(userLocation: UserLocation) -> AnyPublisher<WeatherResponse, WeatherIssue> {
        let lat = userLocation.lat
        let long = userLocation.long
        return parseWeather(urlcomplements: getComponents(lat: lat, lon: long))
    }
    
    func parseWeather<WeatherResponse: Decodable>(urlcomplements: URLComponents)-> AnyPublisher<WeatherResponse, WeatherIssue> {
        guard let url = urlcomplements.url else {
            let urlError = WeatherIssue.connection(desc: "URL invalide")
            return Fail(error: urlError).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .mapError { error in
                WeatherIssue.connection(desc: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { output in
                self.decode(output.data)
            }
            .eraseToAnyPublisher()
    }
    
    func decode<WeatherResponse: Decodable>(_ data: Data)-> AnyPublisher<WeatherResponse, WeatherIssue> {
        return Just(data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .mapError { error in
                WeatherIssue.json(desc: "JSon invalide \(error.localizedDescription)")
            }
            .eraseToAnyPublisher()
    }
    
    func getComponents(lat: Double, lon: Double)-> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "appid", value: key)
        ]
        
        return urlComponents
    }
    
}
