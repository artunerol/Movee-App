//
//  TVSeriesTopRatedCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 19.01.2022.
//

import UIKit
import Kingfisher

class TVSeriesTopRatedCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var ratingContainerView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func configureCellContainerView() {
        ratingContainerView.layer.cornerRadius = 8
        image.layer.cornerRadius = 8
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func configureCell(apiResult: TopRatedResultResponse, imageSize: ServiceURL) { // conifugring the cell with response due to having multiple sections to configure
        configureCellContainerView()
        guard let title = apiResult.name else { return }
        guard let voteAverage = apiResult.voteAverage else { return }
        guard let posterPath = apiResult.posterPath else { return }

        let imageURLString = StaticStringsList.imageBaseURL + imageSize.description + posterPath
        let imageURL = URL(string: imageURLString)

        self.image.kf.setImage(with: imageURL)
        self.title.text = title
        self.ratingLabel.text = String(voteAverage)
    }

}
