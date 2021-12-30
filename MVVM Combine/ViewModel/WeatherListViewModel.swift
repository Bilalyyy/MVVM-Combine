//
//  WeatherListViewModel.swift
//  MVVM Combine
//
//  Created by bilal on 30/12/2021.
//

import SwiftUI
import Combine

class WeatherListViewModel: ObservableObject {
    @Published var weatherList: [WeatherViewModel] = []
    @ObservedObject var api = weatherApi()
    var cancellable = Set<AnyCancellable>()
    
    
    func requestforecast(userLocation: UserLocation) {
        api.getWeather(userLocation: userLocation)
            .map { weatherResponse in
                weatherResponse.list.map { forecast in
                    WeatherViewModel(weather: forecast)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] response in
                switch response {
                case .failure: self?.weatherList = []
                case .finished: break
                }
            }) {[weak self] result in
                guard let self = self else { return }
                self.weatherList = result
            }
            .store(in: &cancellable)

    }
}
