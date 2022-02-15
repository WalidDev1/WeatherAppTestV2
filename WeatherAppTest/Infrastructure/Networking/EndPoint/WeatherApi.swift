//
//  WeatherApi.swift
//  WeatherAppTest
//
//  Created by walidS on 12/2/2022.
//

import Foundation

public enum WeatherApi {
    case weatherbyCityOrCoordinat(cityName: String , nbDay : Int)
    case weatherbyAutoComplet(val: String)
}
extension WeatherApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "http://api.worldweatheronline.com/premium/v1/") else { fatalError("baseURL could not be configured.")}
        return url
    }
//
//    var key : String = "07662ec5a8f0485e800195545221002"
//
    var path: String {
        switch self {
            case .weatherbyCityOrCoordinat :
                return "weather.ashx"
            case .weatherbyAutoComplet:
                return "search.ashx"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .weatherbyAutoComplet(let val):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters:
                                        ["q": val,
                                         "key": key ?? "" ,
                                         "format": format ?? "",
                                         "num_of_results": 10
                                        ])
       
        case .weatherbyCityOrCoordinat(let cityName  , let nbDay):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters:
                                        ["q":  cityName,
                                         "num_of_days": nbDay,
                                         "key": key ?? "" ,
                                         "format": format ?? ""
                                        ])
        }
    }
        
    var headers: HTTPHeaders? {
        return nil
    }
    
    var key: String? {
//        return "07662ec5a8f0485e800195545221002"
        return "78922cf9a4f64d479dd222437221302"
    }
    var format: String? {
        return "json"
    }
    
}

