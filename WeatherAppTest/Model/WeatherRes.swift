//
//  WeatherRes.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation

struct FirstRes {

    let dataRes: WeatherRes
}

extension FirstRes: Decodable  {

    private enum FirstResKeys: String, CodingKey {
        case dataRes = "data"
    }

    init(from decoder: Decoder) throws {
        let FirstRescontainer = try decoder.container(keyedBy: FirstResKeys.self)
        dataRes = try FirstRescontainer.decode(WeatherRes.self, forKey: .dataRes)
    }
}

struct WeatherRes {
    let request: [RequestLocal]
    let currentCondition: [CurrentCondition]
    let weather : [Weather]
}

extension WeatherRes: Codable {

    enum WeatherResKeys: String, CodingKey {
        case request = "request"
        case currentCondition = "current_condition"
        case weather = "weather"
    }

    init(from decoder: Decoder) throws {
        let WeatherResContainer = try decoder.container(keyedBy: WeatherResKeys.self)
        request = try WeatherResContainer.decode([RequestLocal].self, forKey: .request)
        currentCondition = try WeatherResContainer.decode([CurrentCondition].self, forKey: .currentCondition)
        weather = try WeatherResContainer.decode([Weather].self, forKey: .weather)
    }
}
