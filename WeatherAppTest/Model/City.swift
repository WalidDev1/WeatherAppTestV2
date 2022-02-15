//
//  City.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation

struct CityRes {

    let name: String
    let country: String
    var tempC: String = ""
    var tempDesc: String = ""
    var weatherIconUrl: String = ""
    
}

extension CityRes: Decodable {

    private enum CityResKeys: String, CodingKey {
        case name = "areaName"
        case country = "country"
    }

    init(from decoder: Decoder) throws {
        let CityResContainer = try decoder.container(keyedBy: CityResKeys.self)
        name = try CityResContainer.decode([[String:String]].self, forKey: .name)[0]["value"] ?? ""
        country = try CityResContainer.decode([[String:String]].self, forKey: .country)[0]["value"] ?? ""
    }
    
  
    init() {
        name = ""
        country = ""
    }
}
