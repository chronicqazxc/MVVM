//
//  APIManager.swift
//  MVVMDemo
//
//  Created by Wayne Hsiao on 2019/5/25.
//  Copyright © 2019 Wayne Hsiao. All rights reserved.
//

import UIKit

enum FetchError: Error {
    case parseError
    case requestError
}
typealias CompleteHandler = (Weather?, FetchError?)->Void

protocol APIManager {
    func fetchWeather(completeHandler: @escaping CompleteHandler)
}

class WeatherFetcher: APIManager {
    static let shared = WeatherFetcher()
}

extension WeatherFetcher {
    func fetchWeather(completeHandler: @escaping CompleteHandler) {
        if let path = Bundle.main.path(forResource: "mock", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let weathers = try decoder.decode([Weather].self, from: data)
                guard let weather = weathers.first else {
                    completeHandler(nil, .parseError)
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    completeHandler(weather, nil)
                }
            } catch {
                completeHandler(nil, .requestError)
            }
        }
    }
}
