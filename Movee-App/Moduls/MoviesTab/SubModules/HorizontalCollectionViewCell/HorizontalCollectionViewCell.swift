//
//  HorizontalCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 16.01.2022.
//

import UIKit
import Kingfisher

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCustomViews()
        // Initialization code
    }

    private func setupCustomViews() {
        moviePoster.backgroundColor = .brown
        moviePoster.contentMode = .scaleToFill
        moviePoster.layer.cornerRadius = 10
        ratingContainer.layer.cornerRadius = 8
    }

    func configureCell(apiResult: PopularMoviesResultResponse, imageSize: ServiceURL) {
        guard let posterPath = apiResult.posterPath else { return }
        guard let movieTitle = apiResult.title else { return }
        guard let rating = apiResult.voteAverage else { return }

        let imageURLString = StaticStringsList.imageBaseURL + imageSize.rawValue + posterPath
        let imageURL = URL(string: imageURLString)

        self.moviePoster.kf.setImage(with: imageURL)
        self.ratingLabel.text = String(rating)
        self.movieTitle.text = movieTitle
    }
}
