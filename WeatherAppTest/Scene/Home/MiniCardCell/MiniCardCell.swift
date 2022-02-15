//
//  MiniCardCell.swift
//  WeatherAppTest
//
//  Created by walidS on 10/2/2022.
//

import Foundation
import UIKit

class MiniCardCell: UICollectionViewCell {
    
    // MARK: - Type Properties
    var initialDate : String = ""
    static let reuseIdentifier = "MiniCardCell"
    
    // MARK: - Views
    @IBOutlet weak var tempCurrent: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var imageTemp: UIImageView!
    
    
    @IBOutlet weak var bgView: UIView!
    // MARK: - Init
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    
    // MARK: - Local Helpers
    
    private func setupUI() {
        self.bgView.layer.masksToBounds = true
        self.bgView.layer.cornerRadius = 20
    }
    
    // MARK: - Public Interfaces
    func configure(condition: CurrentCondition ){
        tempCurrent.text = condition.tempC
        imageTemp.loadFromUrl(url: URL(string: condition.weatherIconUrl[0]["value"] ?? "")!)
        
        if let dateGeted = initialDate.ToDate() {
            time.text = "\(dateGeted.addingTimeInterval(Double(condition.time)! * 60 ).getOnlyTime())"
        }
                            
    }
    
    func configureOtherDay(condition: Weather ){
        tempCurrent.text = condition.avgTemp
        imageTemp.loadFromUrl(url: URL(string: condition.listCondition[4].weatherIconUrl[0]["value"] ?? "")!)
        let formater = DateFormatter()
        formater.dateFormat = "E, d"
        
        time.text = formater.string(from: condition.date.ToDate()!)
        
                            
    }
    
    // MARK: - Actions
    
    
}

