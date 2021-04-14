//
//  ViewController.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 22/02/21.
//

import UIKit
import RxSwift

class MovieViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    let viewModel = MovieViewModel()
    let disposeBag = DisposeBag()
    let router = MovieRouter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.movieList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movieListResponse?.data?.contents?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as? MovieTableViewCell, let movie = self.viewModel.getMovie(index: indexPath.row) {
            cell.setup(movie: movie)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router.react(to: .movieDetail, from: self, info: self.viewModel.getMovieId(index: indexPath.row))
    }
}

// MARK: - Services
extension MovieViewController {
    
    func movieList() {
        self.view.startLoading()
        self.viewModel.movieList()
            .observe(on: MainScheduler.instance).subscribe(onNext: { (response) in
                self.tableView.reloadData()
                self.tableView.isHidden = false
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
extension MovieViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> MovieViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MovieViewController
    }
}

