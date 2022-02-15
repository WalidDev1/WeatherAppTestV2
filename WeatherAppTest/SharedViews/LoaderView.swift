//
//  Loader.swift
//  WeatherAppTest
//
//  Created by walidS on 13/2/2022.
//

import Foundation
import UIKit

public class LoaderView : UIView {
    
    let imageView = UIImageView()

      init(frame: CGRect, image: UIImage) {
          super.init(frame: frame)

          imageView.frame = bounds
          imageView.image = image
          imageView.contentMode = .scaleAspectFit
          imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          addSubview(imageView)
      }

      required init(coder: NSCoder) {
          fatalError()
      }

      func startAnimating() {
          isHidden = false
          rotate()
      }

      func stopAnimating() {
          isHidden = true
          removeRotation()
      }

      private func rotate() {
      
        
          let pulseAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = 0.0
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
                opacityAnimation.fromValue = 1
                opacityAnimation.toValue = 0.0
        
        let groupAnimation = CAAnimationGroup()
                groupAnimation.animations = [pulseAnimation, opacityAnimation]
                groupAnimation.duration = 2
                groupAnimation.repeatCount = .infinity
        groupAnimation.autoreverses = true
               
          self.imageView.layer.add(groupAnimation, forKey: "rotationAnimation")
      }

      private func removeRotation() {
           self.imageView.layer.removeAnimation(forKey: "rotationAnimation")
      }
  }

