//
//  LoadingConvenience.swift
//  Top Bank
//
//  Created by Thiago on 14/02/20.
//  Copyright © 2020 Valecard. All rights reserved.
//

import UIKit

class LoadingConvenience {
    
    static let shared = LoadingConvenience()
    
    private var loadingView: UIView!
    private var window = (UIApplication.shared.delegate as! AppDelegate).window!
    
    static var blurView: UIVisualEffectView {
        
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.alpha = 0.85
        
        return view
    }
    
    static var shadowView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.55
        return view
    }
    
    static var activityIndicator: UIActivityIndicatorView {
        let loading = UIActivityIndicatorView(style: .whiteLarge)
        loading.color = UIColor.white
        return loading
    }
    
    static var textLoading: UILabel {
        let text = UILabel()
        text.text = ""
        return text
    }
    
//    static var animationView: AnimationView {
//        var lottieView = AnimationView()
//        lottieView = AnimationView.init(name: "sucess")
//        lottieView.frame.size = CGSize(width: 200, height: 200)
//        lottieView.loopMode = .loop
//        lottieView.play()
//        return lottieView
//    }
    
    // MARK: - Life Cycle
    
    init() {
        setupLoadingView()
    }
    
    // MARK: - Misc
    
    func enableFullScreenLoading() {
        //window.addSubview(loadingView)
        UIApplication.shared.keyWindow!.addSubview(loadingView)
        
        
    }
    
    func disableFullScreenLoading() {
        loadingView.removeFromSuperview()
    }
    
    private func setupLoadingView() {
//        loadingView = UIView(frame: window.bounds)
        loadingView = UIView()
        loadingView.frame = UIApplication.shared.keyWindow!.frame
//        loadingView.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
//        loadingView.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
//        loadingView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
//        loadingView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
//        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.startLoading()
    }
    
}
