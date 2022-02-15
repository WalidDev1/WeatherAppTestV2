//
//  UImageView+Extension.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func loadFromUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
