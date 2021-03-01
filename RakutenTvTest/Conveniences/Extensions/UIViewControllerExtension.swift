//
//  UIViewControllerExtension.swift
//  Top Bank
//
//  Created by Thiago on 13/12/19.
//  Copyright © 2019 Valecard. All rights reserved.
//

import UIKit
import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Lifecycle
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - MISC
    public func showAlertError(for error: Error) {
        guard let serviceError = error as? ServiceError, let alertText = serviceError.message else { return }
        let bottomAlertController = BottomAlertViewController.instantiateNew(withText: alertText)
        bottomAlertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        let transition = CATransition()
        transition.duration = 0.5
        transition.subtype = CATransitionSubtype.fromBottom
        if(self.view.window == nil){
             print ("We cant instanciate a window")
        } else {
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.present(bottomAlertController, animated: false, completion:  nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let transition = CATransition()
            transition.duration = 0.5
            transition.subtype = CATransitionSubtype.fromTop
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.dismiss(animated: false)
            }
        }
    }
    
    public func showAlertError(message: String) {
        let bottomAlertController = BottomAlertViewController.instantiateNew(withText: message)
        bottomAlertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        let transition = CATransition()
        transition.duration = 0.5
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.present(bottomAlertController, animated: false, completion:  nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let transition = CATransition()
            transition.duration = 0.5
            transition.subtype = CATransitionSubtype.fromTop
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.dismiss(animated: false)
        }
    }
}
