//
//  WeatherViewModel.swift
//  MVVMDemo
//
//  Created by Wayne Hsiao on 2019/5/25.
//  Copyright © 2019 Wayne Hsiao. All rights reserved.
//

import Foundation
import SimpleReactive

struct WeatherViewModel {
    let city = SimpleColdSignal(" ")
    let temperature = SimpleColdSignal(" ")
    let precipitation = SimpleColdSignal(" ")
    let fetcher: APIManager
    init(_ fetcher: APIManager = WeatherFetcher.shared) {
        self.fetcher = fetcher
    }
    
    typealias WeatherViewModelCompleteHander = (FetchError?)->Void
    
    func fetchWeather(completeHandler: @escaping WeatherViewModelCompleteHander) {
        DispatchQueue.main.async() {
            self.city.next(" ")
            self.temperature.next(" ")
            self.precipitation.next(" ")
        }
        
        fetcher.fetchWeather { (weather, error) in
            if let weather = weather {
                self.city.next(weather.city)
                self.temperature.next("tempreture: \(weather.temperature)˚C")
                self.precipitation.next("precipitation: \(weather.precipitation)%")
                completeHandler(nil)
            } else if let error = error {
                switch error {
                case .parseError:
                    DispatchQueue.main.async() {
                        self.city.next("Oops!")
                        self.temperature.next("Something error.")
                        self.precipitation.next("")
                        completeHandler(error)
                    }
                case .requestError:
                    DispatchQueue.main.async() {
                        self.city.next("Oops!")
                        self.temperature.next("\(error.localizedDescription)")
                        self.precipitation.next("")
                        completeHandler(error)
                    }
                }
            }
        }
    }
}
