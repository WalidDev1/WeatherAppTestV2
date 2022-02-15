//
//  String+Extention.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation

extension String {
    
    func ToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone?
        formatter.dateFormat = "hh:mm a"
        if formatter.date(from: self) != nil {
            return formatter.date(from: self)!
        }
        formatter.dateFormat = "yyyy-MM-dd"
        if formatter.dateFormat != nil {
            return formatter.date(from: self)!
        }
        return nil
    }
}
