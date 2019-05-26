//
//  MockWeatherFetcher.swift
//  MVVMDemoTests
//
//  Created by Wayne Hsiao on 2019/5/26.
//  Copyright © 2019 Wayne Hsiao. All rights reserved.
//

import UIKit
@testable import MVVMDemo

class MockWeatherFetcher: APIManager {
    var isAPICalled = false
    func fetchWeather(completeHandler: @escaping CompleteHandler) {
        isAPICalled = true
        let weather = Weather(location: nil, city: "Test", temperature: 30, precipitation: 30)
        completeHandler(weather, nil)
    }
}

class MockeParseFailureService: APIManager {
    static let shared = MockeParseFailureService()
    func fetchWeather(completeHandler: @escaping CompleteHandler) {
        completeHandler(nil, .parseError)
    }
}

class MockRequestFailureService: APIManager {
    static let shared = MockeParseFailureService()
    func fetchWeather(completeHandler: @escaping CompleteHandler) {
        completeHandler(nil, .requestError)
    }
}
