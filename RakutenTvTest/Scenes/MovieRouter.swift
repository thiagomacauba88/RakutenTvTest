//
//  MovieRouter.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 23/02/21.
//

import UIKit

enum MovieRouterEvent {
    case movie
    case movieDetail
}

class MovieRouter {

    // MARK: - Segue
    enum MovieSegue {
        case movie
        case movieDetail
    }
    
    //MARK: - Properties
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: - Actions
    func react(to event: MovieRouterEvent, from source: UIViewController, info: Any?) {
        switch event {
        case .movie:
            self.showMovie(from: source, info: info)
        case .movieDetail:
            self.showMovieDetail(from: source, info: info)
        }
    }
    
    private func showMovie(from source: UIViewController, info: Any?) {
        let movieViewController = MovieViewController.instantiate(fromStoryboard: storyboard)
        perform(.movie, from: source, to: movieViewController)
    }
    
    private func showMovieDetail(from source: UIViewController, info: Any?) {
        let movieDetailViewController = MovieDetailViewController.instantiate(fromStoryboard: storyboard)
        movieDetailViewController.movieId = info as! String
        perform(.movieDetail, from: source, to: movieDetailViewController)
    }
}

// MARK: - Navigation
private extension MovieRouter {
    
    func perform(_ segue: MovieSegue, from source: UIViewController, to controller: UIViewController) {
        source.navigationController?.pushViewController(controller, animated: true)
    }
}
