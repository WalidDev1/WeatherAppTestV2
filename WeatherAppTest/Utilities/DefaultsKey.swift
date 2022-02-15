//
//  DefaultsKey.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation

/// Generic DefaultsKey that will be used as UserDefaults value
final class DefaultsKey<T>: DefaultsKeys {
    let value: String

    init(_ value: String) {
        self.value = value
    }
}
