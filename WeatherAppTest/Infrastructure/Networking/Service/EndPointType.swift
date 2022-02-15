//
//  EndPointType.swift
//  WeatherAppTest
//
//  Created by walidS on 12/2/2022.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var key: String? { get }
    var format: String? { get }
}
