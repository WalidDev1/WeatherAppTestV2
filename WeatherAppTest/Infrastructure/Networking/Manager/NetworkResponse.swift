//
//  NetworkResponse.swift
//  WeatherAppTest
//
//  Created by walidS on 12/2/2022.
//

import Foundation

enum NetworkResponse: String {
    case success
    case refuse = "Your request has been refused"
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    let router = RouterApi<WeatherApi>()
    
    func weatherbyCityOrCoordinat(cityName: String,nbDay: Int, completion: @escaping(_ isSucces :  Bool ,_ values: WeatherRes? , _ error : String? )->()){
        router.request(.weatherbyCityOrCoordinat(cityName: cityName, nbDay: nbDay)){ (data, response, error) in
            if error != nil {
                completion(false,nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(false,nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(FirstRes.self, from: responseData)
                        completion(true,apiResponse.dataRes ,nil)
                    }catch {
                        print(error)
                        completion(false,nil , NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(false, nil,networkFailureError)
                }
            }
        }
    }
    
    func weatherbyAutoComplete(val: String , completion: @escaping(_ isSucces :  Bool ,_ values: [CityRes]? , _ error : String? )->()){
        router.request(.weatherbyAutoComplet(val: val)){ (data, response, error) in
            if error != nil {
                completion(false,nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(false,nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        
                        guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any] else{return }
                        guard let res = jsonData["search_api"] as? [String : Any] else{return }
                        let newJsonData = try JSONSerialization.data(withJSONObject: res["result"] ?? "", options: [])
                        let apiResponse = try JSONDecoder().decode([CityRes].self, from: newJsonData)
                        completion(true,apiResponse ,nil)
                    }catch {
                        print(error)
                        completion(false,nil , NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(false, nil,networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500:
            if(response.statusCode == 422) {return .failure(NetworkResponse.refuse.rawValue)}
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

}


