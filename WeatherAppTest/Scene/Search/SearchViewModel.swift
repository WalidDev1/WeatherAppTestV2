//
//  SearchViewModel.swift
//  WeatherAppTest
//
//  Created by walidS on 11/2/2022.
//

import Foundation

class SearchViewModel {
    
    // MARK: - Properties
    var listCity : [CityRes]? = []
    var networkManager: NetworkManager!
    

    // MARK: - Init

    init() {
        networkManager = NetworkManager()
    }

    // MARK: - Routing
    
}
//MARK: - Request
extension SearchViewModel {
    
    func getWeatherByCity(city: String ,completion: @escaping(_ isSucces : Bool , _ error : String? )->()){
        networkManager.weatherbyAutoComplete(val: city ){ (isSucces,values, erreur) in
            if isSucces {
                self.listCity = values
                // second call to get the weather_information of the citys
                if let list =  self.listCity{
                        for (index , city) in list.enumerated() {
                            self.networkManager.weatherbyCityOrCoordinat(cityName: city.name ,  nbDay: 1 ){ isSucces , valuesW , erreur in
                                if  isSucces {
                                    self.listCity?[index].tempC = valuesW?.currentCondition[0].tempC ?? ""
                                    self.listCity?[index].tempDesc = valuesW?.currentCondition[0].weatherDesc[0]["value"] ?? ""
                                    self.listCity?[index].weatherIconUrl = valuesW?.currentCondition[0].weatherIconUrl[0]["value"] ?? ""
                                }
                                completion(erreur?.count ?? 0 > 0 ? false : true, erreur)
                            }
                        }
                }
                 
            }
            
        }
    }
    
    func getCitySmallInfo(completion: @escaping(_ isSucces : Bool , _ error : String? )->()) {
        if let list =  self.listCity{
            DispatchQueue.main.async {
                for (index , city) in list.enumerated() {
                    self.networkManager.weatherbyCityOrCoordinat(cityName: city.name ,  nbDay: 1 ){ isSucces , valuesW , erreur in
                        if  isSucces {
                            self.listCity?[index].tempC = valuesW?.currentCondition[0].tempC ?? ""
                            self.listCity?[index].tempDesc = valuesW?.currentCondition[0].weatherDesc[0]["value"] ?? ""
                            self.listCity?[index].weatherIconUrl = valuesW?.currentCondition[0].weatherIconUrl[0]["value"] ?? ""
                        }
                        completion(erreur?.count ?? 0 > 0 ? false : true, erreur)
                    }
                }
            }
        }
    }
    
}
