//
//  LoaderViewController.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation
import UIKit

protocol Loadable {
    func showLoadingView()
    func hideLoadingView()
}

fileprivate struct Constants {
    /// an arbitrary tag id for the loading view, so it can be retrieved later without keeping a reference to it
    fileprivate static let loadingViewTag = 1234
    fileprivate static let backgroundViewTag = 987
}

private var backgroundView: UIView = {
    let backgroundView = UIView()
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    backgroundView.tag = Constants.backgroundViewTag
    backgroundView.backgroundColor = .clear
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.translatesAutoresizingMaskIntoConstraints = false
       blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    backgroundView.addSubview(blurEffectView)
    return backgroundView
}()

/// Default implementation for UIViewController
extension Loadable where Self: UIViewController {
    
    func showLoadingView() {
        let loadingView = LoaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), image: #imageLiteral(resourceName: "sun"))
        
        view.addSubview(backgroundView)
        backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
       
       
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.startAnimating()

        loadingView.tag = Constants.loadingViewTag
    }
    
    func hideLoadingView() {
        view.subviews.forEach { subview in
            if subview.tag == Constants.loadingViewTag || subview.tag == Constants.backgroundViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}
