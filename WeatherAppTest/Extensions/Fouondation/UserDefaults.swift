//
//  UserDefaults.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Generic Get and Set
    
    func get<T>(_ key: DefaultsKey<T>) -> T? {
        return object(forKey: key.value) as? T
    }

    func set<T>(_ key: DefaultsKey<T>, to value: T) {
        set(value, forKey: key.value)
    }
}
