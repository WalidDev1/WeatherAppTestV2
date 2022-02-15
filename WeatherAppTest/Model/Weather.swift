//
//  Weather.swift
//  WeatherAppTest
//
//  Created by walidS on 12/2/2022.
//

import Foundation

struct Weather {
    let date: String
    let avgTemp: String
    let listCondition: [CurrentCondition]
}

extension Weather: Codable {

    enum WeatherKeys: String, CodingKey {
        case date = "date"
        case avgTemp = "avgtempC"
        case listCondition = "hourly"
    }

    init(from decoder: Decoder) throws {
        let weatherContainer = try decoder.container(keyedBy: WeatherKeys.self)
        date = try weatherContainer.decode(String.self, forKey: .date)
        avgTemp = try weatherContainer.decode(String.self, forKey: .avgTemp)
        listCondition = try weatherContainer.decode([CurrentCondition].self, forKey: .listCondition)
    }
}
