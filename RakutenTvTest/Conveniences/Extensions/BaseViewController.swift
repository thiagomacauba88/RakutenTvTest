//
//  BaseViewController.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 04/04/21.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationImage()
    }
    
    // MARK: - MISC
    func initNavigationImage() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal , toItem: nil , attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
         imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal , toItem: nil , attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        imageView.image = logo
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
}

