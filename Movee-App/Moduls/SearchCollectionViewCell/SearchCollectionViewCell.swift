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

    func configureCell<T: Codable>(for apiResult: T) {
        setupContainerView()
        if let apiResult = apiResult as? SearchResultAPIResponse {
            setupCellWithSearch(with: apiResult)
        }
        if let apiResult = apiResult as? [CastResponse] {
            
        }
    }

    private func setupContainerView() {
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
    }

    private func setupCellWithSearch(with apiResult: SearchResultAPIResponse) {
        guard let typeLabel = apiResult.mediaType?.description else { return }
        guard let mediaType = apiResult.mediaType else { return }
        let title = (apiResult.title ?? "") + (apiResult.name ?? "")

        let imageURLString = StaticStringsList.imageBaseURL +
        ServiceURL.w500Poster.description +
        (apiResult.profilePath ?? "") +
        (apiResult.posterPath ?? "")
        let imageURL = URL(string: imageURLString)

        posterImage.kf.setImage(with: imageURL)
        self.titleLabel.text = title
        self.typeLabel.text = typeLabel

        switch mediaType {
        case .movie:
            typeImage.image = UIImage(named: "moviesIcon")
        case .person:
            typeImage.image = UIImage(named: "personIcon")
        case .tvision:
            typeImage.image = UIImage(named: "tvSeriesIcon")
        case .defaultType:
            break
        }
    }

    private func setupCellWithCast(with apiResult: CastResultResponse) {
        subLabel.text = (apiResult.name ?? "") + ", "
    }
}
