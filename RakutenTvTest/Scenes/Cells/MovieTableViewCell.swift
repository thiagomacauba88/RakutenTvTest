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
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var watchedLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - MISC
    func setup(movie: MovieResponse) {
        if let snapshot = movie.images?.snapshot {
            if let url = URL(string: snapshot) {
                let resources = ImageResource(downloadURL: url, cacheKey: snapshot)
                self.movieImageView.kf.setImage(with: resources)
            }
        }
        self.movieName.text = movie.title
        self.ratingLabel.text = movie.highlighted_score?.score?.description
        self.watchedLabel.text = movie.highlighted_score?.formatted_amount_of_votes
    }
}
