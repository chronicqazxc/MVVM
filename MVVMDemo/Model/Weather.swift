//
//  Weather.swift
//  MVVMDemo
//
//  Created by Wayne Hsiao on 2019/5/20.
//  Copyright © 2019 Wayne Hsiao. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var location: Location?
    let city: String
    let temperature: Int
    let precipitation: Int
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case location
        case temperature
        case precipitation
    }
}

struct Location: Codable {
    let lattitude: Double
    let longitude: Double
}
