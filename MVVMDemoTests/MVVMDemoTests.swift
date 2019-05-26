//
//  MVVMDemoTests.swift
//  MVVMDemoTests
//
//  Created by Wayne Hsiao on 2019/5/20.
//  Copyright © 2019 Wayne Hsiao. All rights reserved.
//

import XCTest
import SimpleReactive
@testable import MVVMDemo

class MVVMDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetcher() {
        let mockeService = MockWeatherFetcher()
        let viewModel = WeatherViewModel(mockeService)
        viewModel.fetchWeather { (error) in
            XCTAssertTrue(mockeService.isAPICalled)
        }
    }
    
    func testFetcherParseFailure() {
        let mockeService = MockeParseFailureService()
        let viewModel = WeatherViewModel(mockeService)
        viewModel.fetchWeather { (error) in
            XCTAssertEqual(viewModel.city.value, "Oops!")
            XCTAssertEqual(viewModel.temperature.value, "Something error.")
        }
    }
    
    func testFetcherRequestFailure() {
        let mockeService = MockRequestFailureService()
        let viewModel = WeatherViewModel(mockeService)
        viewModel.fetchWeather { (error) in
            XCTAssertEqual(viewModel.city.value, "Oops!")
            XCTAssertEqual(viewModel.temperature.value, "The operation couldn’t be completed. (MVVMDemo.FetchError error 1.)")
        }
    }
    
    func testBind() {
        let mockeService = MockWeatherFetcher()
        let cityLabel = UILabel()
        let temperatureLabel = UILabel()
        let precipitationLabel = UILabel()
        let viewModel = WeatherViewModel(mockeService)
        viewModel.city.bindTo(label: cityLabel)
        viewModel.temperature.bindTo(label: temperatureLabel)
        viewModel.precipitation.bindTo(label: precipitationLabel)
        viewModel.fetchWeather { (error) in
            XCTAssertEqual(cityLabel.text!, "Test")
            XCTAssertEqual(temperatureLabel.text!, "tempreture: 30˚C")
            XCTAssertEqual(precipitationLabel.text!, "precipitation: 30%")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
