//
//  homeController.swift
//  WeatherAppTest
//
//  Created by walidS on 10/2/2022.
//

import Foundation
import UIKit
import CoreLocation

class HomeViewController: UIViewController , Loadable {
    // MARK: - View
    
    @IBOutlet weak var collectionViewHeurTemp: UICollectionView!
    @IBOutlet weak var tempCurrent: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageTempCurrent: UIImageView!
    @IBOutlet weak var switcherDays: UISegmentedControl!
    @IBOutlet weak var descriptionTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var speedWinds: UILabel!
    @IBOutlet weak var presure: UILabel!
    
    @IBOutlet weak var currentTimeView: UIView!
    // MARK: - Proprties
    var loader: UIAlertController!
    var viewModel: HomeViewModel? = HomeViewModel()
    var locationManager : UserLocationManager? = UserLocationManager()
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.locationManager?.AskPermission()
        InitialLoad(city: "Rabat")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SetUpCollection()
        locationManager?.delegate = self
    }
    
    // MARK: - Init
    private func SetUpCollection() {
        collectionViewHeurTemp.register(UINib(nibName: MiniCardCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MiniCardCell.reuseIdentifier)
        collectionViewHeurTemp.delegate = self
        collectionViewHeurTemp.dataSource = self
    }

    private func setupUI() {
        
        currentTimeView.layer.cornerRadius = 15
        
    }
    // MARK: - Function
    
    private func UpdateView(condition: CurrentCondition ,request: RequestLocal ){
        DispatchQueue.main.async {
            self.tempCurrent.text = condition.tempC
            self.date.text = condition.time
            self.location.text = request.title
            self.imageTempCurrent.loadFromUrl(url: URL(string: condition.weatherIconUrl[0]["value"] ?? "")!)
            self.humidity.text = condition.humidity+" %"
            self.presure.text = condition.pressure
            self.speedWinds.text = condition.windspeedKmph+" Km/h"
            self.descriptionTemp.text = condition.weatherDesc[0]["value"]
            
        }
    }
    
//    func AskLocation() {
//
//    }
    
     func InitialLoad(city: String){
        showLoadingView()
        DispatchQueue.main.async {
            self.viewModel?.getWeatherByCity(city: city){ isSucces , erreur in
                guard let currentWeather = self.viewModel?.currentWeather else { return }
                guard let request = self.viewModel?.request else {  return }
                self.UpdateView(condition: currentWeather, request: request)
                DispatchQueue.main.async {
                    self.collectionViewHeurTemp.reloadData()
                    self.hideLoadingView()
                }
            }
        }
    }
    
  
    // MARK: - Action
    @IBAction func OnClickSearch(_ sender: UIButton) {
        let selectionvc = storyboard?.instantiateViewController(withIdentifier:"SearchView") as! SearchViewController
        selectionvc.delegate = self
        present(selectionvc, animated: true, completion: nil)
    }
    
    @IBAction func ReloadView(_ sender: UIButton) {
        if self.viewModel?.request?.type == "City" {
            InitialLoad(city: self.viewModel?.request?.title ?? "")
        }else{
            locationManager?.AskPermission()
        }
        
    }
    
    @IBAction func SwitchDay(sender: UISegmentedControl) {

        DispatchQueue.main.async {
            self.collectionViewHeurTemp.reloadData()
        }

    }
    
}
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (switcherDays.selectedSegmentIndex == 0) ? viewModel?.nextDayWeather?[0].listCondition.count ?? 0 : viewModel?.nextDayWeather?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewHeurTemp.dequeueReusableCell(withReuseIdentifier: MiniCardCell.reuseIdentifier, for: indexPath) as? MiniCardCell else { return UICollectionViewCell() }
        if switcherDays.selectedSegmentIndex == 0 {
            guard let condition = viewModel?.nextDayWeather?[0].listCondition[indexPath.row] else{ return cell}
            cell.initialDate = viewModel?.nextDayWeather?[0].date ?? ""
            cell.configure(condition: condition)
        }else{
            guard let weather = viewModel?.nextDayWeather?[indexPath.row] else{ return cell}
            cell.configureOtherDay(condition: weather)
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 80)
    }
    
}
extension HomeViewController : SearchViewDelegate {
    
    func didselectCity(city: String) {
            self.InitialLoad(city: city)
    }
    
    func didselectCurrentLocalisation() {
        locationManager?.AskPermission()
    }
    
}
extension HomeViewController : UserLocationManagerDelegate{
    func UpdateCoordoner(lat: CLLocationDegrees, lng: CLLocationDegrees) {
        InitialLoad(city: "\(lat),\(lng)")
    }
    
    
}
