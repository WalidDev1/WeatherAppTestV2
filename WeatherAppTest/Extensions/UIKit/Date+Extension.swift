//
//  Date+Extension.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation

extension Date {
    
    func ConvertTimeToSeconde() -> Int {
        let calendar = Calendar.current // or e.g. Calendar(identifier: .persian)

        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let second = calendar.component(.second, from: self)
        return (hour * 3600)+(minute * 60)+(second)
    }
    
    func getOnlyTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
}
