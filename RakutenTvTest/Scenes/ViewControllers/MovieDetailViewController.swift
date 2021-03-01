//
//  MovieDetailViewController.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 23/02/21.
//

import UIKit
import Kingfisher
import RxSwift
import AVKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieNameLabel: UILabel! {
        didSet {
            self.movieNameLabel.text = ""
        }
    }
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.imageView.image = nil
        }
    }
    @IBOutlet weak var ratingLabel: UILabel!  {
        didSet {
            self.ratingLabel.text = ""
        }
    }
    @IBOutlet weak var watchedLabel: UILabel! {
        didSet {
            self.watchedLabel.text = ""
        }
    }
    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            self.yearLabel.text = ""
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            self.ageLabel.text = ""
        }
    }
    @IBOutlet weak var movieDescriptionLabel: UILabel! {
        didSet {
            self.movieDescriptionLabel.text = ""
        }
    }
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            self.priceLabel.text = ""
        }
    }
    
    // MARK: - Properties
    let viewModel = MovieViewModel()
    let disposeBag = DisposeBag()
    var movieId = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movie(movieId: movieId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - IBActions
    @IBAction func traillerButtonTapped(_ sender: Any) {
        self.movieStreaming(movieId: movieId)
    }
    
    @IBAction func backbuttonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - MISC
    private func initViews() {
        self.setGradient()
        if let snapshot = self.viewModel.movieItemResponse?.data?.images?.snapshot {
            if let url = URL(string: snapshot) {
                let resources = ImageResource(downloadURL: url, cacheKey: snapshot)
                self.imageView.kf.setImage(with: resources)
            }
        }
        self.movieNameLabel.text = self.viewModel.movieItemResponse?.data?.title
        self.ratingLabel.text = self.viewModel.movieItemResponse?.data?.scores?.first?.score?.description
        self.watchedLabel.text = self.viewModel.movieItemResponse?.data?.scores?.first?.formatted_amount_of_votes
        self.yearLabel.text = self.viewModel.movieItemResponse?.data?.year?.description
        self.movieDescriptionLabel.text = self.viewModel.movieItemResponse?.data?.plot
        if let age = self.viewModel.movieItemResponse?.data?.classification?.age?.description {
            self.ageLabel.text = "+" + age
        }
        self.priceLabel.text = self.viewModel.movieItemResponse?.data?.order_options?.first?.price
    }
    
    private func setGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.3, 1]
        imageView.layer.mask = gradient
    }
    
    private func playStreaming(url: String) {
        if let videoURL = URL(string: url) {
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
        }
    }
}

// MARK: - Services
extension MovieDetailViewController {
    
    func movie(movieId: String) {
        self.view.startLoading()
        self.viewModel.movie(movieId: self.movieId)
            .observe(on: MainScheduler.instance).subscribe(onNext: { (response) in
                self.initViews()
            }, onError: { (error) in
                self.showAlertError(for: error)
            }, onCompleted: {
                self.view.stopLoading()
            }, onDisposed: {
                self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
    
    func movieStreaming(movieId: String) {
        let movieStreamingRequest = MovieStreamingRequest()
        movieStreamingRequest.audio_language = "SPA"
        movieStreamingRequest.audio_quality = "2.0"
        movieStreamingRequest.content_id = movieId
        movieStreamingRequest.content_type = "movies"
        movieStreamingRequest.device_serial = "AABBCCDDCC112233"
        movieStreamingRequest.device_stream_video_quality = "FHD"
        movieStreamingRequest.player = "ios:PD-NONE"
        movieStreamingRequest.subtitle_language = "MIS"
        movieStreamingRequest.video_type = "trailer"
        self.view.startLoading()
        self.viewModel.movieStreaming(movieStreamingRequest: movieStreamingRequest)
            .observe(on: MainScheduler.instance).subscribe(onNext: { (response) in
                if let url = self.viewModel.movieStreamingResponse?.data?.stream_infos?.first?.url {
                    self.playStreaming(url: url)
                }
            }, onError: { (error) in
                self.showAlertError(for: error)
            }, onCompleted: {
                self.view.stopLoading()
            }, onDisposed: {
                self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
}

// MARK: - Instantiation
extension MovieDetailViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> MovieDetailViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MovieDetailViewController
    }
}
