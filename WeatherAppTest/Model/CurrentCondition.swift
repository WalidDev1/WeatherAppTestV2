//
//  CurrentCondition.swift
//  WeatherAppTest
//
//  Created by walidS on 12/2/2022.
//

import Foundation

struct CurrentCondition {
    let time : String
    let tempC: String
    let weatherIconUrl: [[String:String]]
    let weatherDesc : [[String:String]]
    let windspeedKmph : String
    let humidity : String
    let pressure : String
}

extension CurrentCondition: Codable {

    enum CurrentConditionKeys: String, CodingKey {
        case timeCurrent = "observation_time"
        case timeNext = "time"
        case tempC = "temp_C"
        case tempNext = "tempC"
        case weatherIconUrl = "weatherIconUrl"
        case weatherDesc = "weatherDesc"
        case windspeedKmph = "windspeedKmph"
        case humidity = "humidity"
        case pressure = "pressure"
        
    }

    init(from decoder: Decoder) throws {
        let CurrentConditionContainer = try decoder.container(keyedBy: CurrentConditionKeys.self)
        time = try CurrentConditionContainer.decodeIfPresent(String.self, forKey: CurrentConditionContainer.contains(.timeCurrent) ? .timeCurrent: .timeNext) ?? "--"
        tempC = try CurrentConditionContainer.decodeIfPresent(String.self, forKey: CurrentConditionContainer.contains(.timeCurrent) ? .tempC : .tempNext) ?? "--"
        weatherIconUrl = try CurrentConditionContainer.decode([[String:String]].self, forKey: .weatherIconUrl)
        weatherDesc = try CurrentConditionContainer.decode([[String:String]].self, forKey: .weatherDesc)
        windspeedKmph = try CurrentConditionContainer.decodeIfPresent(String.self, forKey: .windspeedKmph) ?? "--"
        humidity = try CurrentConditionContainer.decodeIfPresent(String.self, forKey: .humidity) ?? "--"
        pressure = try CurrentConditionContainer.decodeIfPresent(String.self, forKey: .pressure) ?? "--"
        
    }
}
