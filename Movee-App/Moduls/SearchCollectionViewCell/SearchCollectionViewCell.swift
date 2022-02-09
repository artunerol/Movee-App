//
//  SearchCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 7.02.2022.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subLabel: UILabel!
    @IBOutlet private weak var typeImage: UIImageView!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!

    func configureCell(apiResult: SearchResultAPIResponse) {
        setupContainerView()
        guard let title = apiResult.title else { return }
        guard let posterPath = apiResult.posterPath else { return }
        guard let typeLabel = apiResult.mediaType?.description else { return }
        guard let mediaType = apiResult.mediaType else { return }

        let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.w500Poster.description + posterPath
        let imageURL = URL(string: imageURLString)

        self.posterImage.kf.setImage(with: imageURL)
        self.titleLabel.text = title
        self.typeLabel.text = typeLabel

        switch mediaType {
        case .movie:
            typeImage.image = UIImage(named: "moviesIcon")
        case .person:
            typeImage.image = UIImage(named: "personIcon")
        case .tvision:
            typeImage.image = UIImage(named: "tvSeriesIcon")
        }
    }

    private func setupContainerView() {
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
    }
}
