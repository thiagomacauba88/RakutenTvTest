//
//  UIViewExtension.swift
//  Top Bank
//
//  Created by Thiago on 13/12/19.
//  Copyright © 2019 Valecard. All rights reserved.
//

import UIKit
import Foundation

fileprivate let loadingViewIdentifier = 101010
fileprivate let loadingLottieViewIdentifier = 202020

extension UIView {
    
    func applyRoundedBorders(with cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = false;
        self.clipsToBounds = true
    }
    
    func setBackgroundGradient(startPoint: CGPoint, endPoint: CGPoint, colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setBorder(color: UIColor) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func removeBorder() {
        self.layer.borderWidth = 0.0
    }
    
    func fadeIn(withDuration duration: TimeInterval = 2.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func startLoading(_ shadow: Bool = true) {
        let loadingView = UIView()
        loadingView.frame = self.bounds
        loadingView.tag = loadingViewIdentifier
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        //label.text = "I'm a test label"
        loadingView.addSubview(label)
        
        let activityIndicator = LoadingConvenience.activityIndicator
        activityIndicator.frame = self.bounds
        
        let a = LoadingConvenience.textLoading
        a.frame = self.bounds
        loadingView.addSubview(label)
        activityIndicator.startAnimating()
        
        if shadow {
            let shadowView = LoadingConvenience.shadowView
            shadowView.frame = self.bounds
            loadingView.addSubview(shadowView)
        }
        
        loadingView.addSubview(activityIndicator)
        
        DispatchQueue.main.async {
            self.window?.addSubview(loadingView)
        }
    }
    
//    func startLoadingLottie() {
//        let loadingView = UIView()
//        loadingView.frame = self.bounds
//        loadingView.tag = loadingLottieViewIdentifier
//        
//        let animationView = LoadingConvenience.animationView
//        animationView.frame.size = CGSize(width: 220, height: 220)
//        
//        animationView.center = loadingView.center
//        loadingView.addSubview(animationView)
//        
//        DispatchQueue.main.async {
//            self.addSubview(loadingView)
//        }
//    }
    
    func stopLoading() {
        let holderView = self.window?.viewWithTag(loadingViewIdentifier)
        DispatchQueue.main.async {
            holderView?.removeFromSuperview()
        }
    }
}
