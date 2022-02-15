//
//  UserLocationManager.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation
import CoreLocation

protocol UserLocationManagerDelegate {
    func UpdateCoordoner(lat: CLLocationDegrees , lng: CLLocationDegrees)
}
class UserLocationManager : NSObject {
    
    var lat : CLLocationDegrees?
    var lng : CLLocationDegrees?
    var delegate :UserLocationManagerDelegate!
    func AskPermission() {
        // Create a CLLocationManager and assign a delegate
        let locationManager = CLLocationManager()
        locationManager.delegate = self

        // Use requestAlwaysAuthorization if you need location
        // updates even when your app is running in the background
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    private func checkLocationAuthorization(){
        
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            break
        case .notDetermined:
            break
        case .restricted:
            break
        case .authorizedAlways, .authorizedWhenInUse:
//            self.CloseView()
            break
            
        @unknown default:
            fatalError()
        }
    }
    
}
extension UserLocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let position = locations.first {
            
            lat  =  position.coordinate.latitude
            lng = position.coordinate.longitude
            delegate.UpdateCoordoner(lat: position.coordinate.latitude , lng: position.coordinate.longitude)
            
        }
        
    }
    func locationManager( _ manager: CLLocationManager,didFailWithError error: Error) {
        // Handle failure to get a user’s location
        print(error)
    }
}
