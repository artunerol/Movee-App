//
//  HorizontalCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 16.01.2022.
//

import UIKit
import Kingfisher

struct HorizontalCollectionViewCellUIModel {
    let posterPath: String
    let title: String
    let rating: Double
}

enum HorizontalCellConfigureType {
    case tvSeries(title: String, posterPath: String, rating: String)
    case movies(title: String, posterPath: String, rating: String)
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

    func configureCell(model: HorizontalCollectionViewCellUIModel) {
        let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.rawValue + model.posterPath
        let imageURL = URL(string: imageURLString)

        self.posterImage.kf.setImage(with: imageURL)
        self.ratingLabel.text = String(model.rating)
        self.titleLabel.text = model.title
    }

    //MARK: - Private funcs
    private func setupCustomViews() {
        posterImage.backgroundColor = .brown
        posterImage.contentMode = .scaleToFill
        posterImage.layer.cornerRadius = 10
        ratingContainer.layer.cornerRadius = 8
    }
}
