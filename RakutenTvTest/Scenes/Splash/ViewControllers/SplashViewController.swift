//
//  SplashViewController.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 04/04/21.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var verticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Properties
    let router = MovieRouter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTyping(text: "Hi Recruiter!")
        self.fadeIn()
    }
    
    // MARK: - MISC
    func setTyping(text: String, characterDelay: TimeInterval = 15) {
        self.textLabel.text = ""
        
      let writingTask = DispatchWorkItem { [weak self] in
        text.forEach { char in
          DispatchQueue.main.async {
            self?.textLabel.text?.append(char)
          }
          Thread.sleep(forTimeInterval: characterDelay/100)
        }
      }
      let queue: DispatchQueue = .init(label: "typespeed", qos: .userInteractive)
      queue.asyncAfter(deadline: .now() + 0.05, execute: writingTask)
    }

    func fadeIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.textLabel.text = ""
            UIView.animate(withDuration: 1.0, animations: {
                let window = UIApplication.shared.windows[0]
                let topPadding = window.safeAreaInsets.top
                let padding = topPadding == 20 ? 13 : -14
                self.verticalConstraint.constant -= CGFloat(padding) + (self.view.bounds.height/2 - self.heightConstraint.constant/2)
                self.heightConstraint.constant = 100
                self.widthConstraint.constant = 150
                self.view.layoutIfNeeded()
                })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            self.router.react(to: .movie, from: self, info: nil)
        }
    }
}

// MARK: - Instantiation
extension SplashViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> SplashViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SplashViewController
    }
}
