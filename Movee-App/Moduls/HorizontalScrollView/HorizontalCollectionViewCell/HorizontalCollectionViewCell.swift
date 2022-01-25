//
//  HorizontalCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 16.01.2022.
//

import UIKit
import Kingfisher

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCustomViews()
    }

    func configureCell(model: CollectionViewCellDataModel) {
        let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + model.posterPath
        let imageURL = URL(string: imageURLString)

        self.posterImage.kf.setImage(with: imageURL)
        self.ratingLabel.text = String(model.rating)
        self.titleLabel.text = model.title
    }

    // MARK: - Private funcs
    private func setupCustomViews() {
        posterImage.backgroundColor = .lightGray
        posterImage.contentMode = .scaleToFill
        posterImage.layer.cornerRadius = 10
        ratingContainer.layer.cornerRadius = 8
    }
}
