//
//  UserSession.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation
// Singleton protocol.
protocol Singleton {
    
    /// Shared instance.
    static var shared: Self { get }
}


final class UserSession: Singleton {
    
    // MARK: - Singleton
    
    /// Settings shared instance
    static let shared = UserSession()
    
    // MARK: - Init
    
    /// Prevent instance creation.
    private init() {}
    
    // MARK: - Private Properties
    
    private var userDefaults: UserDefaults { UserDefaults.standard }

    // MARK: - Properties
    
    var listCity: [[String:String]]? {
        get { userDefaults.get(.listCity) }
        set { userDefaults.set(.listCity, to: newValue ?? [[:]]) }
    }
}
