//
//  homeViewModel.swift
//  WeatherAppTest
//
//  Created by walidS on 10/2/2022.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    var currentWeather : CurrentCondition?
    var nextDayWeather : [Weather]?
    var request : RequestLocal?
    var networkManager: NetworkManager!

    // MARK: - Init
    init() {
        networkManager = NetworkManager()
    }
}
//MARK: - Request

extension HomeViewModel {
    
    func getWeatherByCity(city: String ,completion: @escaping(_ isSucces : Bool , _ error : String? )->()){
        networkManager.weatherbyCityOrCoordinat(cityName: city , nbDay: 5){ (isSucces,values, erreur) in
            if isSucces {
                self.currentWeather = values?.currentCondition[0]
                self.nextDayWeather = values?.weather
                self.request = values?.request[0]
            }
            completion(erreur?.count ?? 0 > 0 ? false : true, erreur)
        }
    }
}
