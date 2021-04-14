//
//  MovieTableViewCell.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 23/02/21.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            self.movieImageView.image = nil
        }
    }
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var watchedLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.movieImageView.image = nil
        self.movieName.text = ""
        self.ratingLabel.text = ""
        self.watchedLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - MISC
    func setup(movie: MovieResponse) {
        DispatchQueue.global().async { [weak self] in
            if let snapshot = movie.images?.snapshot {
                if let url = URL(string: snapshot) {
                    let resources = ImageResource(downloadURL: url, cacheKey: snapshot)
                    DispatchQueue.main.async {
                        self?.movieImageView.kf.setImage(with: resources)
                    }
                }
            }
        }
        self.movieName.text = movie.title
        self.ratingLabel.text = movie.highlightedScore?.score?.description
        self.watchedLabel.text = movie.highlightedScore?.formattedAmountOfVotes
        self.setNeedsLayout()
    }
}
