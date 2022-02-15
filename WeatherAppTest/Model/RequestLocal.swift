//
//  RequestLocal.swift
//  WeatherAppTest
//
//  Created by walidS on 12/2/2022.
//

import Foundation

struct RequestLocal {
    let type: String
    let title: String
}

extension RequestLocal: Codable {

    enum RequestLocalKeys: String, CodingKey {
        case type = "type"
        case title = "query"
    }

    init(from decoder: Decoder) throws {
        let requestLocalContainer = try decoder.container(keyedBy: RequestLocalKeys.self)
        type = try requestLocalContainer.decode(String.self, forKey: .type)
        title = try requestLocalContainer.decode(String.self, forKey: .title)
    }
}
