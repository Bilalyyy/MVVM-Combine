//
//  WeatherProtocol.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import Foundation
import Combine

protocol WeatherProtocol {
    func getWeather(userLocation: UserLocation) ->
        AnyPublisher<WeatherResponse , WeatherIssue>
}
