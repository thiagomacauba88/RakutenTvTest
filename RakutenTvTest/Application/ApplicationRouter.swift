//
//  ApplicationRouter.swift
//  Top Bank
//
//  Created by Thiago on 14/02/20.
//  Copyright © 2020 Valecard. All rights reserved.
//

import UIKit
class ApplicationRouter {

    // MARK: - Enum
    enum ApplicationStartPoint {
        case initial
    }
    
    // MARK: - Properties
    fileprivate lazy var signInStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: - Lifecycle
    func startApplication(in window: UIWindow?) {
        guard let window = window else { return }
        self.startApplication(in: window, startPoint: .initial)
    }
    
    func startApplication(in window: UIWindow, startPoint: ApplicationStartPoint) {
        switch startPoint {
        case .initial:
            let viewController = MovieViewController.instantiate(fromStoryboard: signInStoryboard)
            let rootNavigationController = UINavigationController(rootViewController: viewController)
            setRootNavigationController(rootNavigationController, for: window)
        }
    }
    
    fileprivate func setRootNavigationController(_ rootNavigationController: UINavigationController, for window: UIWindow) {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        rootNavigationController.navigationBar.titleTextAttributes = textAttributes
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }
}
