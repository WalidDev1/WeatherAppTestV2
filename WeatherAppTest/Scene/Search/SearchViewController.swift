//
//  SearchViewController.swift
//  WeatherAppTest
//
//  Created by walidS on 11/2/2022.
//

import Foundation
import UIKit

protocol SearchViewDelegate {
    func didselectCity(city: String)
    func didselectCurrentLocalisation()
}

class SearchViewController: UIViewController , Loadable {
    // MARK: - Proprties
    @IBOutlet weak var collectionViewResult: UICollectionView!
    @IBOutlet weak var citySearch: UITextField!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var bgTextField: UIView!
    @IBOutlet weak var bgbtn: UIView!
    
    
    // MARK: - Proprties
    var delegate: SearchViewDelegate!
    private var viewModel: SearchViewModel? = SearchViewModel()
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        initialList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SetUpCollection()
    }
    
    // MARK: - Init
    private func SetUpCollection(){
        collectionViewResult.register(UINib(nibName: CardSearchCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CardSearchCell.reuseIdentifier)
        collectionViewResult.delegate = self
        collectionViewResult.dataSource = self
    }
    
    private func setupUI() {
        bgbtn.layer.cornerRadius = 15
        bgTextField.layer.cornerRadius = 15
    }
    
    // MARK: - func
    
    
    func showResults(string: String) {
        showLoadingView()
        self.viewModel?.getWeatherByCity(city: string){ isSucces , erreur in
            if isSucces {
                DispatchQueue.main.async {
                    self.collectionViewResult.reloadData()
                    self.hideLoadingView()
                }
            }
        }
    }
    
    func initialList() {
        showLoadingView()
        self.viewModel?.listCity?.removeAll()
        guard let listeCity = UserSession.shared.listCity else{return}
        for city in  listeCity {
            self.viewModel?.listCity?.append(CityRes(name: city["name"] ?? "", country: city["country"] ?? "", tempC: "", tempDesc: "", weatherIconUrl: ""))
        }
        
        viewModel?.getCitySmallInfo(){isSucces , erreur in
            DispatchQueue.main.async {
                self.collectionViewResult.reloadData()
                self.hideLoadingView()
            }
        }
    }
// MARK: - Action
    @IBAction func OnClickCurrentLocation(_ sender: UIButton) {
        delegate.didselectCurrentLocalisation()
        self.dismiss(animated: true, completion: nil)
    }
}
extension SearchViewController  : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CardSearchCelldelegate {
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.initialList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.listCity?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewResult.dequeueReusableCell(withReuseIdentifier: CardSearchCell.reuseIdentifier, for: indexPath) as? CardSearchCell else { return UICollectionViewCell() }
        cell.delegate = self
        if let city = viewModel?.listCity?[indexPath.row]{
            cell.configure(city: city)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let city = viewModel?.listCity?[indexPath.row] {
            delegate.didselectCity(city: city.name+" "+city.country)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        let fullText = text.replacingCharacters(in: range, with: string)
        
        if fullText.count == 0 {
            initialList()
        } else if fullText.count > 2 { 
            showResults(string:fullText)
        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
