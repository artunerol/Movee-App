//
//  HorizontalCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 16.01.2022.
//

import UIKit
import Kingfisher

enum HorizontalCellConfigureType {
    case tvSeries
    case movies
}

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCustomViews()
    }

    func configureCell<T: Decodable>(apiResult: T, imageSize: ServiceURL, configureType: HorizontalCellConfigureType) {
        switch configureType {
        case .tvSeries:
            configureTVSeries(apiResult: apiResult as! TopRatedResultResponse, imageSize: imageSize)
        case .movies:
            configureMovies(apiResult: apiResult as! PopularAPIResultResponse, imageSize: imageSize)
        }
    }

    //MARK: - Private funcs

    private func configureMovies(apiResult: PopularAPIResultResponse, imageSize: ServiceURL) {
        guard let posterPath = apiResult.posterPath else { return }
        guard let movieTitle = apiResult.title else { return }
        guard let rating = apiResult.voteAverage else { return }

        let imageURLString = StaticStringsList.imageBaseURL + imageSize.rawValue + posterPath
        let imageURL = URL(string: imageURLString)

        self.posterImage.kf.setImage(with: imageURL)
        self.ratingLabel.text = String(rating)
        self.titleLabel.text = movieTitle
    }

    private func configureTVSeries(apiResult: TopRatedResultResponse, imageSize: ServiceURL) {
        guard let posterPath = apiResult.posterPath else { return }
        guard let movieTitle = apiResult.name else { return }
        guard let rating = apiResult.voteAverage else { return }

        let imageURLString = StaticStringsList.imageBaseURL + imageSize.rawValue + posterPath
        let imageURL = URL(string: imageURLString)

        self.posterImage.kf.setImage(with: imageURL)
        self.ratingLabel.text = String(rating)
        self.titleLabel.text = movieTitle
    }

    private func setupCustomViews() {
        posterImage.backgroundColor = .brown
        posterImage.contentMode = .scaleToFill
        posterImage.layer.cornerRadius = 10
        ratingContainer.layer.cornerRadius = 8
    }
}
