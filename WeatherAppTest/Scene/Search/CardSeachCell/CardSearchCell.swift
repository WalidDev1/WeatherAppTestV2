//
//  CardSearchCell.swift
//  WeatherAppTest
//
//  Created by walidS on 11/2/2022.
//

import Foundation
import UIKit

protocol CardSearchCelldelegate: class { // the name of the protocol you can put any
    func updateTableView()
}
class CardSearchCell: UICollectionViewCell {
    
    // MARK: - Type Properties
    var isSaved : Bool = false
    var cityCell : CityRes?
    var delegate : CardSearchCelldelegate!
    static let reuseIdentifier = "CardSearchCell"
    
    // MARK: - Views
    
    @IBOutlet weak var tempCurrent: UILabel!
    @IBOutlet weak var tempdescription: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var imageTemp: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    // MARK: - init
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Local Helpers
    
    private func setupUI() {
        self.contentView.layer.cornerRadius = 15
    }
    
    // MARK: - Public Interfaces
    func configure(city: CityRes ){
        cityCell = city
        cityName.text = city.name+" , "+city.country
        tempCurrent.text = city.tempC
        if city.weatherIconUrl != "" {
            imageTemp.loadFromUrl(url: URL(string: city.weatherIconUrl)!)
        }
        tempdescription.text = city.tempDesc
        guard let listeSaved = UserSession.shared.listCity else {return}
        for c in listeSaved {
            guard let nameCity = c["name"] else{return}
            guard let countryCity = c["country"] else{return}
            if nameCity.lowercased().contains(city.name.lowercased()) && countryCity.lowercased().contains(city.country.lowercased()) {
                btnSave.setTitle("Remove", for: .normal)
                btnSave.setImage(.remove, for: .normal)
                isSaved = true
                break
            }else{
                isSaved = false
                btnSave.setTitle("Save", for: .normal)
                btnSave.setImage(.add, for: .normal)
                
            }
        }
       
    }
    // MARK: - Action
    @IBAction func OnClickSave(_ sender: UIButton) {
        if let cityN = cityCell {
            if isSaved {
                guard let listeCitySaved = UserSession.shared.listCity else{return}
                for (index , city ) in listeCitySaved.enumerated() {
                    if city["name"]!.lowercased().contains(cityN.name.lowercased()) && city["country"]!.lowercased().contains(cityN.country.lowercased()) {
                        UserSession.shared.listCity?.remove(at: index)
                        break
                    }
                }
            } else {
                UserSession.shared.listCity?.append(["name": cityN.name, "country": cityN.country ])
            }
        }
        delegate.updateTableView()
       
    }
    
}

